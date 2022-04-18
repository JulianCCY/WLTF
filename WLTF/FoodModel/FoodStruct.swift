//
//  Food.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import Foundation

struct FoodStruct: Hashable, Codable {
    var foodId: UUID
    var name: String
    var category: String
    var entryDate: String
    var expiryDate: Date
    var amount: Double
    var unit: String
}

//struct FoodStruct: Hashable {
//    var name: String
//    var category: String
//    var entryDate: String
//    var expireDate: Date
//    var amount: Double
//    var unit: String
//}
