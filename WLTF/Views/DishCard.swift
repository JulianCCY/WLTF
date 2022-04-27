//
//  DishCard.swift
//  WLTF
//
//  Created by iosdev on 25.4.2022.
//

import SwiftUI

struct DishCard: View {
    
    var title: String
    var image: String
    var ingredients: [String]
    var color: String = "BackgroundColor"
    @State var suff: Bool = true
    
    private func suffColor(bool: Bool) -> String {
        if bool {
            return "Green"
        } else {
            return "Red"
        }
    }
    
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
//                Spacer()
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
            Circle()
                .fill(Color("\(color)"))
//                .frame(width: 230, height: 230)
                .shadow(color: Color.gray.opacity(0.2), radius: 10, x: 0, y: 0)
        )
        .onAppear{
            suff = checkSuff(arr: ingredients)
        }
        
    }
}

//struct DishCard_Previews: PreviewProvider {
//    static var previews: some View {
//        DishCard()
//    }
//}
