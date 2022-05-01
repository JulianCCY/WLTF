//
//  FridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI
import CoreData
import Foundation
import AVFoundation

struct ClosedFridgeScreen: View {
    
//    init() {
//            UITabBar.appearance().backgroundColor = UIColor.white
//    }
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var fridgeName: String = ""
    @State private var navigate = false
    @State private var showNote: Bool = false
    @State private var noteType: String = ""
    @State private var noteArr: [FoodStruct] = []
    
    // separate 3 color of sticky notes by expires in 1 days, 3 days and expired
    @State private var orange: Bool = false
    @State private var red: Bool = false
    @State private var purple: Bool = false
    
    @State private var orangeCount: Int = 0
    @State private var redCount: Int = 0
    @State private var purpleCount: Int = 0
    
    @State private var expiringFoodArr: [[FoodStruct]] = []
    
//     this funcation transform multi d NSObject to multi d FoodStruct object
    private func filterArr() -> [[FoodStruct]] {
        expiringFoodArr = []
        expiringFoodArr = DataController().fetchGoingToBeExpired().map{$0.map{FoodStruct(foodId: $0.id! ,name: $0.name!, category:$0.category!, entryDate:$0.entryDate!, expiryDate: $0.expiryDate!, amount: $0.amount, unit: $0.unit!, remaining: $0.remaining)}}
        (purple, purpleCount) = (expiringFoodArr[0].isEmpty ? false : true, expiringFoodArr[0].count)
        (red, redCount) = (expiringFoodArr[1].isEmpty ? false : true, expiringFoodArr[1].count)
        (orange, orangeCount) = (expiringFoodArr[2].isEmpty ? false : true, expiringFoodArr[2].count)

        return expiringFoodArr
    }
    
    func playSound() {
        var filePath: String?
        filePath = Bundle.main.path(forResource: "open-fridge", ofType: "mp3")
        let fileURL = URL(fileURLWithPath: filePath!)
        var soundID:SystemSoundID = 0
        AudioServicesCreateSystemSoundID(fileURL as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
//    Get fridge name
    private func getName() {
        fridgeName = DataController().fetchFridgeName()
    }
    
    var body: some View {      
        ZStack {        
            NavigationLink(destination: InsideFridgeScreen(), isActive: $navigate) {
                Button {
                    playSound()
                    navigate.toggle()
                } label: {
                    Image("Closedfridge")
                        .resizable()
                        .frame(maxWidth: .infinity, minHeight: 625)
                        .overlay(
                            ZStack {
                                
                                VStack {
                                    HStack{
                                        Spacer()
                                        NavigationLink(destination: Settings()) {
                                            Image(systemName: "questionmark.square.fill")
                                                .resizable()
                                                .frame(width: 35, height: 35, alignment: .trailing)
                                                .foregroundColor(Color("PrimaryColor"))
                                                .padding(EdgeInsets(top: 35, leading: 0, bottom: 0, trailing: 10))
                                        }
                                    }
                                    Spacer()
                                }
                                
                                VStack {
                                    Text("\(fridgeName)")
                                        .font(.custom("AvenirNextCondensed-Heavy", size: 24))
                                        .fontWeight(.semibold)
                                        .foregroundColor(Color.black)
                                        .padding(.top, 70)
    //                                        .padding(.leading, 20)
                                        .frame(maxWidth: .infinity, alignment: .center)
    //                                        .rotation3DEffect(.degrees(10), axis: (x: 0, y: -9, z: -9))
                                    
                                    Spacer()
                                }
                                
                                
                                VStack {
                                    Spacer()

                                        ZStack {
                                            Button {
                                                showNote.toggle()
                                                noteType = "3days"
                                                noteArr = expiringFoodArr[2]
                                            } label: {
                                                Image("Orange note")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .overlay(
                                                        Text("\(orangeCount)")
                                                            .foregroundColor(Color.black)
                                                            .font(.custom("Marker Felt", size: 30))
                                                    )
                                                    .rotationEffect(.degrees(-15))
                                            }
                                        }
                                        .offset(x: -70, y: -80)
                                        .opacity(orange ? 1 : 0)
                                        .allowsHitTesting(orange)

                                        ZStack {
                                            Button {
                                                showNote.toggle()
                                                noteType = "1day"
                                                noteArr = expiringFoodArr[1]
                                            } label: {
                                                Image("Red note")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .overlay(
                                                        Text("\(redCount)")
                                                            .foregroundColor(Color.black)
                                                            .font(.custom("Marker Felt", size: 30))
                                                    )
                                                    .rotationEffect(.degrees(20))
                                            }
                                        }
                                        .offset(x: 80, y: -140)
                                        .opacity(red ? 1 : 0)
                                        .allowsHitTesting(red)
                                    
                                        ZStack {
                                            Button {
                                                showNote.toggle()
                                                noteType = "expired"
                                                noteArr = expiringFoodArr[0]
                                            } label: {
                                                Image("Purple note")
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                    .overlay(
                                                        Text("\(purpleCount)")
                                                            .foregroundColor(Color.black)
                                                            .font(.custom("Marker Felt", size: 30))
                                                    )
                                                    .rotationEffect(.degrees(-5))
                                            }
                                        }
                                        .offset(x: -30, y: -135)
                                        .opacity(purple ? 1 : 0)
                                        .allowsHitTesting(purple)
                                    }

                
                            }
                        )
                }
            }
            
                
//                NavigationLink(destination: InsideFridgeScreen()) {
//                    Image("Closedfridge")
//                        .resizable()
//                        .frame(maxWidth: .infinity, minHeight: 625)
//                        .overlay(
//                            ZStack {
//
//                                VStack {
//                                    HStack{
//                                        Spacer()
//                                        NavigationLink(destination: Settings()) {
//                                            Image(systemName: "questionmark.square.fill")
//                                                .resizable()
//                                                .frame(width: 35, height: 35, alignment: .trailing)
//                                                .foregroundColor(Color("PrimaryColor"))
//                                                .padding(EdgeInsets(top: 35, leading: 0, bottom: 0, trailing: 10))
//                                        }
//                                    }
//                                    Spacer()
//                                }
//
//                                VStack {
//                                    Text("\(fridgeName)")
//                                        .font(.custom("AvenirNextCondensed-Heavy", size: 24))
//                                        .fontWeight(.semibold)
//                                        .foregroundColor(Color.black)
//                                        .padding(.top, 70)
////                                        .padding(.leading, 20)
//                                        .frame(maxWidth: .infinity, alignment: .center)
////                                        .rotation3DEffect(.degrees(10), axis: (x: 0, y: -9, z: -9))
//
//                                    Spacer()
//                                }
//
//
//                                VStack {
//                                    Spacer()
//
//                                        ZStack {
//                                            Button {
//                                                showNote.toggle()
//                                                noteType = "3days"
//                                                noteArr = expiringFoodArr[2]
//                                            } label: {
//                                                Image("Orange note")
//                                                    .resizable()
//                                                    .frame(width: 100, height: 100)
//                                                    .overlay(
//                                                        Text("\(orangeCount)")
//                                                            .foregroundColor(Color.black)
//                                                            .font(.custom("Marker Felt", size: 30))
//                                                    )
//                                                    .rotationEffect(.degrees(-15))
//                                            }
//                                        }
//                                        .offset(x: -70, y: -80)
//                                        .opacity(orange ? 1 : 0)
//                                        .allowsHitTesting(orange)
//
//                                        ZStack {
//                                            Button {
//                                                showNote.toggle()
//                                                noteType = "1day"
//                                                noteArr = expiringFoodArr[1]
//                                            } label: {
//                                                Image("Red note")
//                                                    .resizable()
//                                                    .frame(width: 100, height: 100)
//                                                    .overlay(
//                                                        Text("\(redCount)")
//                                                            .foregroundColor(Color.black)
//                                                            .font(.custom("Marker Felt", size: 30))
//                                                    )
//                                                    .rotationEffect(.degrees(20))
//                                            }
//                                        }
//                                        .offset(x: 80, y: -140)
//                                        .opacity(red ? 1 : 0)
//                                        .allowsHitTesting(red)
//
//                                        ZStack {
//                                            Button {
//                                                showNote.toggle()
//                                                noteType = "expired"
//                                                noteArr = expiringFoodArr[0]
//                                            } label: {
//                                                Image("Purple note")
//                                                    .resizable()
//                                                    .frame(width: 100, height: 100)
//                                                    .overlay(
//                                                        Text("\(purpleCount)")
//                                                            .foregroundColor(Color.black)
//                                                            .font(.custom("Marker Felt", size: 30))
//                                                    )
//                                                    .rotationEffect(.degrees(-5))
//                                            }
//                                        }
//                                        .offset(x: -30, y: -135)
//                                        .opacity(purple ? 1 : 0)
//                                        .allowsHitTesting(purple)
//                                    }
//
//
//                            }
//                        )
//                }//                    Navigationlink
//                .simultaneousGesture(
//                    TapGesture().onEnded{
//                        if showNote == false {
//                            playSound()
//                        }
//                    })
                .navigationTitle("")
                .navigationBarHidden(true)
                .onAppear{
                    expiringFoodArr = filterArr()
                    getName()
//                    let synthesizer = AVSpeechSynthesizer()
//                    let utterance = AVSpeechUtterance(string: "Hello")
//                    synthesizer.speak(utterance)
                }
            .allowsHitTesting(!showNote)
//            .edgesIgnoringSafeArea(.top)
            
            NotesUI(note: $noteType, show: $showNote, arr: $noteArr)
            
//            zstack
        }
        
        
    }
}

//struct ClosedFridgeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        ClosedFridgeScreen()
//    }
//}
