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
    var color: String = "BackhgroundColor"
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("\(title)")
            }
        }
        
    }
}

struct DishCard_Previews: PreviewProvider {
    static var previews: some View {
        DishCard()
    }
}
