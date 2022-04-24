//
//  FridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI
import CoreData
import Foundation

struct ClosedFridgeScreen: View {
    
    init() {
            UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
//    @State var imgName: String = "Closedfridge"
    @State private var closedFridge = true
    @State private var showNote: Bool = false
    @State private var noteType: String = ""
    @State private var noteArr: [FoodStruct] = []
    
//    Because of swiftui cant handle if else conditional rendering, we use stupid solutions "index out of range" swift said
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
        expiringFoodArr = DataController().fetchGoingToBeExpired().map{$0.map{FoodStruct(foodId: $0.id! ,name: $0.name!, category:$0.category!, entryDate:$0.entryDate!, expiryDate: $0.expiryDate!, amount: $0.amount, unit: $0.unit!)}}
        (purple, purpleCount) = (expiringFoodArr[0].isEmpty ? false : true, expiringFoodArr[0].count)
        (red, redCount) = (expiringFoodArr[1].isEmpty ? false : true, expiringFoodArr[1].count)
        (orange, orangeCount) = (expiringFoodArr[2].isEmpty ? false : true, expiringFoodArr[2].count)

        return expiringFoodArr
    }
    
    var body: some View {      
        ZStack {
            VStack {
                Text("Name of your fridge")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 30, leading: 20, bottom: 0, trailing: 0))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .navigationTitle("")
                    .navigationBarHidden(true)
                
                NavigationLink(destination: InsideFridgeScreen()) {
                    Image("Closedfridge")
                        .resizable()
                        .frame(maxWidth: .infinity, minHeight: 625)
                        .padding()
                        .overlay(
                            VStack {
                                Spacer()
//                                if orange {
                                    ZStack {
                                        Button {
                                            showNote.toggle()
                                            noteType = "3days"
                                            noteArr = expiringFoodArr[2]
//                                            print(expiringFoodArr[2].count)
                                        } label: {
                                            Image("Orange note")
                                                .resizable()
                                                .frame(width: 100, height: 100)
                                                .overlay(
                                                    Text("\(orangeCount)")
                                                        .foregroundColor(Color.black)
                                                        .font(.title)
                                                )
                                                .rotationEffect(.degrees(-15))
                                        }
                                    }
                                    .offset(x: -70, y: -80)
                                    .opacity(orange ? 1 : 0)
                                    .allowsHitTesting(orange)
//                                }

//                                if red {
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
                                                        .font(.title)
                                                )
                                                .rotationEffect(.degrees(20))
                                        }
                                    }
                                    .offset(x: 70, y: -140)
                                    .opacity(red ? 1 : 0)
                                    .allowsHitTesting(red)
//                                }

//                                if purple {
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
                                                        .font(.title)
                                                )
                                                .rotationEffect(.degrees(-5))
                                        }
                                    }
                                    .offset(x: -30, y: -135)
                                    .opacity(purple ? 1 : 0)
                                    .allowsHitTesting(purple)
                                }

//                            }
                        )
//                    Navigation
                }
                .onAppear{
                    expiringFoodArr = filterArr()
                }
                //vstack
            }
            .allowsHitTesting(!showNote)
            
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
