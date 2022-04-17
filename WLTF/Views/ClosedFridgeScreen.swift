//
//  FridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI

struct ClosedFridgeScreen: View {
    
    @State var imgName: String = "Closed fridge"
    @State var closedFridge = true
    
    var body: some View {
        NavigationView {
//            VStack {
//                Rectangle()
//                    .fill(Color("PrimaryPink"))
//                    .frame(height: 110)
//                    .overlay(
//                        Text("Fridge name")
//                            .font(.largeTitle)
//                            .offset(y: 10)
//                            .foregroundColor(Color.white)
//                    )
//                    .shadow(radius: 5)
//                    .edgesIgnoringSafeArea(.top)
//                Image("Closed fridge")
//                    .resizable()
//                    .offset(y: -20)
//                    .frame(width: .infinity, height: 650)
//                    .padding([.leading, .trailing])
//            }
            
//            if (closedFridge) {
//                Button(action: {
//                    closedFridge = false
//                }) {
//                    Image("Closed fridge")
//                        .resizable()
//                }
//            } else {
//                NavigationLink(destination: InsideFridgeScreen()) {
//                    Image("Opened fridge")
//                        .resizable()
//                        .frame(width: 1000, height: 650)
//        //                .offset(y: -50)
//        //                .ignoresSafeArea()
//                        .padding([.leading, .trailing])
//                        .navigationBarTitle("Name of your fridge")
//        //                .navigationBarHidden(true)
//                }
//            }
            
//            Button(action: {
//                self.imgName = "Opened fridge"
//            }) {
//                Image(imgName)
//                    .resizable()
//            }
            
            NavigationLink(destination: InsideFridgeScreen()) {
                Image("Closed fridge")
                    .resizable()
                    .frame(width: .infinity, height: 650)
    //                .offset(y: -50)
    //                .ignoresSafeArea()
                    .padding([.leading, .trailing])
                    .navigationBarTitle("Name of your fridge")
    //                .navigationBarHidden(true)
            }
            
        }
        .navigationBarHidden(true)
    }
}

struct ClosedFridgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClosedFridgeScreen()
    }
}
