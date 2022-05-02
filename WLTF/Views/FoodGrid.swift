//
//  FoodGrid.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//
// This view represent individual food item displayed by lazy v grid
// Displayed as blocks on InsideFridgeScreen

import SwiftUI

struct FoodGrid: View {
    
    var food: FoodStruct
    
    var body: some View {
        VStack {
            Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                .resizable()
                .frame(width: 50, height: 50)
            Text("\(food.name)")
        }
        .frame(width: 80, height: 80)
        .background(Color("\(FoodImgFunc.selectColor(food.expiryDate))"))
        .cornerRadius(10)
    }

}
