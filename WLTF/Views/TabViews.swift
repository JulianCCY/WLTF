//
//  TabViews.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//

import SwiftUI

struct TabViews: View {
    var body: some View {
        NavigationView {
            TabView {
                DishMain()
                    .tabItem {
                        Image(systemName: "magazine")
                        Text("Cookbook")
                    }
        //                .navigationBarHidden(true)
                ClosedFridgeScreen()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
        //                .navigationBarHidden(true)
                ShoppingList()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Shopping list")
                    }
        //                .navigationBarHidden(true)
                }
//                .navigationBarTitle("")
//                .navigationBarHidden(true)
//                .navigationBarBackButtonHidden(true)
    //        .navigationBarTitle("", displayMode: .inline)
    //        .ignoresSafeArea()
        }
    }
}

struct TabViews_Previews: PreviewProvider {
    static var previews: some View {
        TabViews()
    }
}
