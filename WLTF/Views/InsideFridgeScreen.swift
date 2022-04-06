//
//  InsideFridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI

struct InsideFridgeScreen: View {
    
    var categoryArr = Array(Set(foodArr.map{$0.category}))
    
    let columns = [
            GridItem(.adaptive(minimum: 80))
        ]
    
    var body: some View {
//        NavigationView {
        VStack {
            NavigationLink(destination: AddFoodScreen()) {
                Text("Add food")
            }
//            List(foodArr, id: \.self) { food in
//                NavigationLink {
//                    FoodDetail()
//                } label: {
//                    FoodRow(food: food)
//                }
//            }
            List(categoryArr, id: \.self) { category in
                Text("\(category)")
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(foodArr.filter{$0.category == category}, id: \.self) { food in
                            NavigationLink {
                                FoodDetail()
                            } label: {
                                FoodGrid(food: food)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .frame(height: 230)
            }
            .navigationBarTitle("All food")
//            ScrollView {
//                LazyVGrid(columns: columns, spacing: 20) {
//                    ForEach(foodArr, id: \.self) { food in
//                        NavigationLink {
//                            FoodDetail()
//                        } label: {
//                            FoodGrid(food: food)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .frame(maxHeight: 230)
//            .navigationBarTitle("All food")
        }
    }
}

struct InsideFridgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        InsideFridgeScreen()
    }
}
