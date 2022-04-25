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
    
    var body: some View {
        
        ZStack {
            VStack {
                Spacer()
                Text("\(title)")
                    .font(.title3)
                    .fontWeight(.medium)
//                    .padding(.top, 10)
                Image("\(image)")
                    .resizable()
                    .frame(width: 120, height: 120)
            }
        }
        .frame(width: 180, height: 180)
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
