//
//  ContentView.swift
//  WLTF
//
//  Created by iosdev on 3.4.2022.
//
// This is the ContentView of the app, which has some UIView initialisations and a tabview
// The tabview is the bottom navigation bar of the app
// The tabview can navigate to Dish screen, Fridge screen, and Shopping list screen, which are the 3 major features of our app.

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var selection = 2
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor(named: "Quaternary")
        UITableView.appearance().backgroundColor = UIColor(Color("TertiaryColor"))
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = UIColor(Color("TertiaryColor"))
        navBarAppearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
    }
 
    
    var body: some View {
 
//        Tabview wrapped by a navigation view
        NavigationView {
            TabView(selection:$selection) {
                DishMain()
                    .tabItem {
                        Image(systemName: "magazine")
                        Text("Menu")
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
                        Text("Grocery")
                    }
                    .tag(3)
            }
            .accentColor(Color("PrimaryColor"))
        }
        .accentColor(Color("PrimaryColor"))
    }
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
