//
//  ContentView.swift
//  WLTF
//
//  Created by iosdev on 3.4.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
//    @State private var navBoolean = false
    @State private var selection = 2
    
    var body: some View {
//        NavigationView {
//            ZStack {
//                Color("PrimaryColor")
//                    .ignoresSafeArea()
//                VStack {
//                    Group {
//                        Text("What Left The Fridge")
//                            .font(.title)
//                            .foregroundColor(.white)
//                        Text("Your personal fridge manager")
//                            .font(.subheadline)
//                            .foregroundColor(.white)
//                    }
//                    .offset(y: -100)
////                    NavigationLink(destination: FridgeScreen(), isActive: $navBoolean) {
////                        Button(action: {self.navBoolean = true}) {
////                            Image("Landing page logo")
////                                .renderingMode(.original)
////                                .clipShape(Circle())
////                        }
////                    }
//                    NavigationLink(destination: TabViews()
//                                    .navigationBarTitle("")
//                                    .navigationBarHidden(true)) {
//                        Image("Landing page logo")
//                            .renderingMode(.original)
//                            .clipShape(Circle())
//                    }
//                }
//            }
//            .navigationBarHidden(true)
//        }
        NavigationView {
            TabView(selection:$selection) {
                DishMain()
                    .tabItem {
                        Image(systemName: "magazine")
                        Text("Cookbook")
                    }
                    .tag(1)
                ClosedFridgeScreen()
                    .tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .tag(2)
                ShoppingList()
                    .tabItem {
                        Image(systemName: "cart")
                        Text("Shopping list")
                    }
                    .tag(3)
            }
        }
    }
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
