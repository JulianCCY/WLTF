//
//  FridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI

struct ClosedFridgeScreen: View {
    
//    @State var imgName: String = "Closedfridge"
    @State var closedFridge = true
    
    var body: some View {
        VStack {
            Text("Name of your fridge")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
                .navigationTitle("")
                .navigationBarHidden(true)
            if (closedFridge) {
                Button(action: {
                    closedFridge = false
//                imgName = "Openedfridge"
                }) {
                    Image("Closedfridge")
                        .resizable()
                        .frame(maxWidth: .infinity, minHeight: 625)
//                        .padding([.leading, .trailing])
                        .padding()
                }
            } else {
                NavigationLink(destination: InsideFridgeScreen().onAppear {closedFridge = true}) {
                    Image("Openedfridge")
                        .resizable()
                        .frame(maxWidth: .infinity, minHeight: 625)
        //                .offset(y: -50)
        //                .ignoresSafeArea()
//                        .padding([.leading, .trailing])
                        .padding()
        //                .navigationBarHidden(true)
                }
//                .simultaneousGesture(TapGesture().onEnded{
//                    closedFridge = true
//                })
            }
        }
        
        
        
//        NavigationView {
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
            
            
            
//        VStack {
//            Text("Name of your fridge")
//                .font(.title)
//                .fontWeight(.bold)
//                .padding(.leading)
//                .frame(maxWidth: .infinity, alignment: .leading)
//            NavigationLink(destination: InsideFridgeScreen()) {
//                Image("Closedfridge")
//                    .resizable()
//                    .frame(maxWidth: .infinity, minHeight: 625)
//        //                .offset(y: -50)
//        //                .ignoresSafeArea()
//                    .padding([.leading, .trailing])
//        //            .navigationBarTitle("Name of your fridge")
//        //                .navigationBarHidden(true)
//            }
//            .navigationTitle("")
//            .navigationBarHidden(true)
//        }
        
        
    }
}

struct ClosedFridgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClosedFridgeScreen()
    }
}
