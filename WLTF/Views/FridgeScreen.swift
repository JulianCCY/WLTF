//
//  FridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI

struct FridgeScreen: View {
    var body: some View {
        VStack {
            Rectangle()
                .fill(Color("PrimaryPink"))
                .frame(height: 110)
                .overlay(
                    Text("Fridge name")
                        .font(.largeTitle)
                        .offset(y: 10)
                        .foregroundColor(Color.white)
                )
                .cornerRadius(10)
                .shadow(radius: 5)
                .edgesIgnoringSafeArea(.top)
            Image("Closed fridge")
                .resizable()
                .offset(y: -25)
                .ignoresSafeArea()
                .padding([.leading, .trailing])
        }
    }
}

struct FridgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        FridgeScreen()
    }
}
