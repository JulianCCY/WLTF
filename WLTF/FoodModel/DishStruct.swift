//
//  DishesStruct.swift
//  WLTF
//
//  Created by Chan Chung Yin on 25/4/2022.
//
// Structure of Dish object

import Foundation


struct DishStruct: Hashable, Codable {
    var dishId: UUID
    var dishName: String
    var dishImg: String
    var portion: Int
    var note: String
    var ingredientArr: [String]
}
