//
//  DishCard.swift
//  WLTF
//
//  Created by iosdev on 25.4.2022.
//
// This view is for the card displayed in DishMain, representing the dishes that the user stored

import SwiftUI

struct DishCard: View {
    
    var title: String
    var image: String
    var ingredients: [String]
    var color: String = "Fridge"
    @State var suff: Bool = true
    
//    Detemine the color displayed, representing sufficient or not
    private func suffColor(bool: Bool) -> String {
        if bool {
            return "Green"
        } else {
            return "Red"
        }
    }
    
//    Checking if the user have corresponding ingredient in the fridge and return a bool
    private func checkSuff(arr: [String]) -> Bool {
        var check: Bool = true
        arr.forEach { i in
            if check == false {
                check = false
            } else if DataController().checkIfExist(foodName: i) {
                check = true
            } else {
               check = false
            }
        }
        return check
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("\(title)")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .padding(.top, 100)
                    .frame(maxWidth: 120)
                Image("\(image)")
                    .resizable()
                    .frame(width: 120, height: 120)
                Circle()
                    .fill(Color("\(suffColor(bool: suff))"))
                    .frame(width: 25, height: 25, alignment: .center)
                    .padding(.bottom, 100)
            }
        }
        .frame(width: 220, height: 220)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("\(color)"))
                .frame(width: 250, height: 250)
                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 0)
        )
        .onAppear{
            suff = checkSuff(arr: ingredients)
        }
        
    }
}
