//
//  DishMain.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//

import SwiftUI
import AVFoundation

struct DishMain: View {
    @State private var recording = false
    @ObservedObject private var mic = MicController(numberOfSamples: 30)
    private var speechManager = SpeechController()
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var dishArr: [DishStruct] = []
    
    @State private var alert = false
    @State private var alertMessage = ""
    
    private func filterArr() -> [DishStruct] {
        dishArr = []
        dishArr = DataController().fetchAllDishes().map{DishStruct(dishId: $0.id!, dishName: $0.dishName!, dishImg: $0.dishImg!, portion: Int($0.portion), note: $0.note!, ingredientArr: DataController().fetchRelatedIngredient(dishId: $0.id!).map{$0.name!})}
        return dishArr
    }
    
    var body: some View {
        
        ZStack {
            
            Color("TertiaryColor")
                .ignoresSafeArea()
            
            VStack (alignment: .leading) {
                VStack {
                    HStack {
                        Text("What to cook?")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .padding(.top, 50)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Spacer()
                }
                
// Horizontal scroll
                if dishArr.isEmpty {
                    Text("You do not have any dishes yet!")
                        .frame(height: 300)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {

                            ForEach(dishArr, id: \.self) { i in

                               GeometryReader { geometry in
                                   NavigationLink {
                                       DishDetail(dish: i)
                                   }
                                   label: {
                                       DishCard(title: i.dishName, image: i.dishImg, ingredients: i.ingredientArr)
                                   }
    //                                   .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -15), axis: (x: 0, y: 10, z: 0))
                               }
                               .frame(width: 250, height: 280)
                           }
                       }
                        .padding(.leading, 80)
                        .padding(.trailing, 50)
                       .padding(.top, 50)
                    }

                }
                
                Spacer()
                
//                Ingredients colors guide
                VStack(alignment: .leading) {
                    Spacer()
                    HStack() {
                        Circle()
                            .fill(Color("Green"))
                            .frame(width: 16, height: 16)
                        Text("Adequate ingredient")
                            .font(.custom("Helvetica", size: 14))
                    }
                    HStack() {
                        Circle()
                            .fill(Color("Red"))
                            .frame(width: 16, height: 16)
                        Text("Inadequate ingredient")
                            .font(.custom("Helvetica", size: 14))
                    }
                }
                .padding(.leading, 30)
                
                
//                buttons to create dish page and speech
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        VStack{
                            Button() {
                                 getSpeech()
                             } label: {
                                 Image(systemName: recording ? "stop.circle.fill" : "waveform.and.mic")
                                     .resizable()
                                     .padding(10)
                                     .frame(width: 50, height: 50)
                                     .foregroundColor(Color("TertiaryColor"))
                                     .background(Color("PrimaryColor"))
                                     .cornerRadius(6)
                             }
                            NavigationLink(destination: DishAdd()) {
                                // Navigate to add food screen
                                Image(systemName: "plus.square.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(Color("PrimaryColor"))
                            }
                        }
                    }
                }
                .padding([.trailing, .bottom])

            } // main vstack
            
//            delete all button 
            VStack {
                HStack {
                    Spacer()
                    Button {
                        alert = true
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 22))
                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 15))
                    }
                    .alert("Delete all of your dishes", isPresented: $alert) {
                        Button("Confirm", role: .destructive) {
                            DataController().deleteAllDishes(context: moc)
                            moc.refreshAllObjects()
                            dishArr = []
                        }
                        Button("Cancel", role: .cancel) { }
                    }
                    .disabled(dishArr.isEmpty)
                }
                Spacer()
            }
        } // big z
        .onAppear{
            dishArr = filterArr()
            speechManager.speechRecognitionAuthorization()
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    private func getSpeech(){
        
        if speechManager.isRecording {
            self.recording = false
            mic.stopMonitoring()
            speechManager.stopRecording()
        } else {
            self.recording = true
            mic.startMonitoring()
            speechManager.listen{ (speechText) in
                guard let speech = speechText, !speech.isEmpty else {
                    self.recording = false
                    return
                }
                NLPController().speechAnalytics(userSpeech: speech)
            }
            
        }
        speechManager.isRecording.toggle()
    }
    
}

struct DishMain_Previews: PreviewProvider {
    static var previews: some View {
        DishMain()
    }
}
