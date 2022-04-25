//
//  DishesStruct.swift
//  WLTF
//
//  Created by Chan Chung Yin on 25/4/2022.
//

import Foundation


struct DishesStruct: Hashable, Codable {
    var dishId: UUID
    var dishName: String
    var portion: Int
    var note: String
    var ingredientArr: [String]
}
