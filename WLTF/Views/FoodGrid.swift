//
//  FoodGrid.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI

struct FoodGrid: View {
    
    var food: FoodStorage
    
    func selectImg(_ input1: String, _ input2: String ) -> String {
        
        if input1.lowercased() == "apple" || input1.lowercased() == "omena" {
            return "apple"
        }
        if input1.lowercased() == "avocado" || input1.lowercased() == "avokado" {
            return "avocado"
        }
        if input1.lowercased() == "beer" || input1.lowercased() == "oluit" {
            return "beer"
        }
        if input1.lowercased() == "onion" || input1.lowercased() == "sipuli" {
            return "onion"
        }
        if input1.lowercased() == "tea" || input1.lowercased() == "coffee" {
            return "hotDrink"
        }
        else {
            if input2.lowercased() == "meat" {
                return "steak"
            }
            if input2.lowercased() == "veg" {
                return "veg1"
            }
            if input2.lowercased() == "dairy" {
                return "milk"
            }
            if input2.lowercased() == "drink" {
                return "bottle"
            }
            if input2.lowercased() == "fruit" {
                return "apple"
            }
            else {
                return "bowl"
            }
        }
    }
    
    func selectColor(_ input: String) -> String {
        return "NormalItem"
    }
    
    var body: some View {
        VStack {
            Image("\(selectImg(food.name, food.category))")
                .resizable()
                .frame(width: 50, height: 50)
            Text("\(food.name)")
        }
        .frame(width: 80, height: 80)
        .background(Color("\(selectColor(food.expireDate))"))
//        .border(Color.black)
        .cornerRadius(10)
    }

}

struct FoodGrid_Previews: PreviewProvider {
    static var previews: some View {
        FoodGrid(food: foodArr[0])
//        FoodGrid(food: foodArr[1])
    }
}
