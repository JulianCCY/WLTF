//
//  DishCard.swift
//  WLTF
//
//  Created by iosdev on 25.4.2022.
//

import SwiftUI

struct DishCard: View {
    
    var title: String = "Dish name"
    var image: String = "wok"
    var color: String = "BackgroundColor"
    var suff: Bool = true
    
    private func suffColor(bool: Bool) -> String {
        if bool {
            return "CheckedItem"
        } else {
            return "1dayItem"
        }
    }
    
    var body: some View {
        
        ZStack {
            VStack {
//                Spacer()
                Text("\(title)")
                    .font(.system(size: 28))
                    .fontWeight(.medium)
                    .padding(.top, 100)
                Image("\(image)")
                    .resizable()
                    .frame(width: 120, height: 120)
                Circle()
                    .fill(Color("\(suffColor(bool: suff))"))
                    .frame(width: 25, height: 25, alignment: .center)
                    .padding(.bottom, 100)
            }
        }
        .frame(width: 240, height: 240)
        .background(
            Circle()
                .fill(Color("\(color)"))
        )
        
    }
}

struct DishCard_Previews: PreviewProvider {
    static var previews: some View {
        DishCard()
    }
}
