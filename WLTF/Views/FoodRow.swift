//
//  FoodRow.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI

struct FoodRow: View {
    
    var food: FoodStorage
    
    var body: some View {
        VStack {
            HStack {
                Text(food.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                Text(food.category)
                    .font(.title)
                Spacer()
                Text("\(food.amount)")
                    .font(.title)
                Text(food.unit)
                    .font(.title)
            }
//            .padding([.top, .leading, .trailing])
            Text("\(food.expireDate)")
        }
    }
}

struct FoodRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FoodRow(food: foodArr[0])
            FoodRow(food: foodArr[1])
        }
//        .previewLayout(.fixed(width: 500, height: 100))
    }
}
