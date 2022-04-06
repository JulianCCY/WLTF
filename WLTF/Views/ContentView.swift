//
//  ContentView.swift
//  WLTF
//
//  Created by iosdev on 3.4.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var navBoolean = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("PrimaryPink")
                    .ignoresSafeArea()
                VStack {
                    Group {
                        Text("What Left The Fridge")
                            .font(.title)
                            .foregroundColor(.white)
                        Text("Your personal fridge manager")
                            .font(.subheadline)
                            .foregroundColor(.white)
                    }
                    .offset(y: -100)
                    NavigationLink(destination: FridgeScreen(), isActive: $navBoolean) {
                        Button(action: {self.navBoolean = true}) {
                            Image("Landing page logo")
                                .renderingMode(.original)
                                .clipShape(Circle())
                        }
                    }
                }
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
