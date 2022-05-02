//
//  DishMain.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//
// This is the DishMain screen, one of the screens that can navigate by tabview
// This screen displays list of dishes that created by the user
// User can see do they have ingredients for the dish
// Speech recongnition implemented

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
                        Text("cook?")
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
                    Text("no_dish")
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
                
//                speechbutton
                HStack{
                    Spacer()
                    ZStack {
                        Circle()
                            .fill(Color("Fridge"))
                            .frame(width: 110, height: 110)
                            .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 0)
                        Button() {
                             getSpeech()
                         } label: {
                             Image(systemName: recording ? "stop.circle.fill" : "waveform.and.mic")
                                 .resizable()
                                 .padding(20)
                                 .frame(width: 100, height: 100)
                                 .foregroundColor(Color("TertiaryColor"))
                                 .background(Color("PrimaryColor"))
                                 .clipShape(Circle())
                                 .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 0)
                         }
                    }
                    Spacer()
                }
                
//                screen bottom -- colors reminder and button
                VStack {
                    Spacer()
                    HStack {
    //                Ingredients colors guide
                        VStack(alignment: .leading) {
                            HStack() {
                                Circle()
                                    .fill(Color("Green"))
                                    .frame(width: 16, height: 16)
                                Text("enough")
                                    .font(.custom("Helvetica", size: 14))
                            }
                            HStack() {
                                Circle()
                                    .fill(Color("Red"))
                                    .frame(width: 16, height: 16)
                                Text("not_enough")
                                    .font(.custom("Helvetica", size: 14))
                            }
                        }
                        
                        Spacer()

    //                buttons to create dish page
                        NavigationLink(destination: DishAdd()) {
                            // Navigate to add food screen
                            Image(systemName: "plus.square.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("PrimaryColor"))
                        }
                    }
                }
                .padding([.leading, .trailing, .bottom])

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
                    .alert("delete_all_dishes", isPresented: $alert) {
                        Button("confirm", role: .destructive) {
                            DataController().deleteAllDishes(context: moc)
                            moc.refreshAllObjects()
                            dishArr = []
                        }
                        Button("cancel", role: .cancel) { }
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
        .environment(\.locale, .init(identifier: UserDefaults.standard.string(forKey: "lang") ?? "en"))
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
