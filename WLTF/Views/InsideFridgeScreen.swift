//
//  InsideFridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI

struct InsideFridgeScreen: View {
    var body: some View {
        NavigationView {
            List(foodArr, id: \.name) { food in
                NavigationLink {
                    FoodDetail()
                } label: {
                    FoodRow(food: food)
                }
            }
            .navigationBarTitle("All food")
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: InsideFridgeScreen()) {
                        Text("Add food")
                    }
            )
        }
    }
}

struct InsideFridgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        InsideFridgeScreen()
    }
}
