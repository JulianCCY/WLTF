//
//  DishCard.swift
//  WLTF
//
//  Created by iosdev on 25.4.2022.
//

import SwiftUI

struct DishCard: View {
    
    var title: String = "Food name"
    var image: String = "wok"
    var color: String = "BackgroundColor"
    
    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.black)
                .padding()
            
            Spacer()
            
            Image(image)
                .resizable()
                .renderingMode(.original)
//                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.bottom, 20)
        }
        .background(
            Circle()
                .fill(Color("\(color)"))
        )
//        .cornerRadius(20)
//        .frame(width: 250, height: 400)
//        .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 10, y: 10)
    }
}

struct DishCard_Previews: PreviewProvider {
    static var previews: some View {
        DishCard()
    }
}
