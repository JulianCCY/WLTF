//
//  Food.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//
// Structure of food object

import Foundation

struct FoodStruct: Hashable, Codable {
    var foodId: UUID
    var name: String
    var category: String
    var entryDate: String
    var expiryDate: Date
    var amount: Double
    var unit: String
    var remaining: Double
}
