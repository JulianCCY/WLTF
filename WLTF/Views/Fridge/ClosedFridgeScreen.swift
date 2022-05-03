//
//  FridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//
// This is the ClosedFridgeScreen, one of the screen that can be navigated from the bottom navigation bar, which is also our home screen
// This screen contains a image of fridge, a navigation to setting/guidelines, a navigation to InsideFridgeScreen and stickynotes

import SwiftUI
import CoreData
import Foundation
import AVFoundation

struct ClosedFridgeScreen: View {
    
//    Coredata
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
//    Some private variables for the screen
    @State private var fridgeName: String = ""
    @State private var navigate = false
    @State private var showNote: Bool = false
    @State private var noteType: String = ""
    @State private var noteArr: [FoodStruct] = []
    
//    Separate 3 color of sticky notes by expiring in 1 days, 3 days and expired
//    Bool is for togging the sticknotes appearance and count is for the numbers on the sticky notes
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
    
//    sound of fridge opening when navigate to inside fridge screen
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
            Color("TertiaryColor")
                .ignoresSafeArea()
            
//            Guideline icon & navigation to settings page
            VStack {
                HStack{
                    Spacer()
                    NavigationLink(destination: Settings()) {
                        Image(systemName: "questionmark.square.fill")
                            .resizable()
                            .frame(width: 35, height: 35, alignment: .trailing)
                            .foregroundColor(Color("PrimaryColor"))
                            .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 10))
                    }
                }
                Spacer()
            }
                
//                FridgeImage
                NavigationLink(destination: InsideFridgeScreen(), isActive: $navigate) {
                    Button {
                        playSound()
                        navigate.toggle()
                    } label: {
                        Image("Fridge")
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom)
                            .overlay(
                                ZStack {
                                    
                    //                Fridgename
                                    HStack {
                                        Spacer()
                                        Text("\(fridgeName)")
                                            .font(.custom("AvenirNextCondensed-Heavy", size: 24))
                                            .fontWeight(.semibold)
                                            .foregroundColor(Color.black)
                                            .offset(y: -80)
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        Spacer()
                                    }
    
//                                    sticky notes
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
                                                        .frame(width: 70, height: 70)
                                                        .overlay(
                                                            Text("\(orangeCount)")
                                                                .foregroundColor(Color.black)
                                                                .font(.custom("Marker Felt", size: 30))
                                                        )
                                                        .rotationEffect(.degrees(-15))
                                                }
                                            }
                                            .offset(x: -60, y: -50)
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
                                                        .frame(width: 70, height: 70)
                                                        .overlay(
                                                            Text("\(redCount)")
                                                                .foregroundColor(Color.black)
                                                                .font(.custom("Marker Felt", size: 30))
                                                        )
                                                        .rotationEffect(.degrees(20))
                                                }
                                            }
                                            .offset(x: 55, y: -70)
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
                                                        .frame(width: 70, height: 70)
                                                        .overlay(
                                                            Text("\(purpleCount)")
                                                                .foregroundColor(Color.black)
                                                                .font(.custom("Marker Felt", size: 30))
                                                        )
                                                        .rotationEffect(.degrees(-5))
                                                }
                                            }
                                            .offset(x: -40, y: -65)
                                            .opacity(purple ? 1 : 0)
                                            .allowsHitTesting(purple)
                                        }
                                }
                            ) // overlay
                    } // label
                } // navigation link          
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear{
                expiringFoodArr = filterArr()
                getName()
            }
            .allowsHitTesting(!showNote)
            
            NotesUI(note: $noteType, show: $showNote, arr: $noteArr)
        }// zstack
        
        
    }
}
