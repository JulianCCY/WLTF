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
    
    init() {
         UITabBar.appearance().barTintColor = UIColor.white
     }
    
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
        
        
//        GeometryReader { geometry in
//             VStack {
//                 Spacer()
//                 Text("Home")
//                 Spacer()
//                 HStack {
//                     TabBarIcon(width: geometry.size.width/3, height: geometry.size.height/28, systemIconName: "magazine", tabName: "Cookbook")
//                     ZStack {
//                          Circle()
//                             .foregroundColor(Color.white)
//                              .frame(width: geometry.size.width/7, height: geometry.size.width/7)
//                              .shadow(radius: 3)
//                         Image(systemName: "house.fill")
//                              .resizable()
//                              .aspectRatio(contentMode: .fit)
//                              .frame(width: geometry.size.width/7-6 , height: geometry.size.width/7-6)
//                              .foregroundColor(Color("SecondaryColor"))
//                      }
//                     .offset(y: -geometry.size.height/8/2)
//                     TabBarIcon(width: geometry.size.width/3, height: geometry.size.height/28, systemIconName: "cart", tabName: "Grocery")
//                 }
//                 .frame(width: geometry.size.width, height: geometry.size.height/8)
//                 .background(Color.white.shadow(radius: 2))
//             }
//             .edgesIgnoringSafeArea(.bottom)
//         }
        
        
        
        
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
                        Text("Grocery")
                    }
                    .tag(3)
            }
        }

        
        
        
    }
}

//struct TabBarIcon: View {
//     
//     let width, height: CGFloat
//     let systemIconName, tabName: String
//     
//     
//     var body: some View {
//         VStack {
//             Image(systemName: systemIconName)
//                 .resizable()
//                 .aspectRatio(contentMode: .fit)
//                 .frame(width: width, height: height)
//                 .padding(.top, 10)
//             Text(tabName)
//                 .font(.footnote)
//             Spacer()
//         }
//         .padding(.horizontal, -4)
//     }
// }

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
