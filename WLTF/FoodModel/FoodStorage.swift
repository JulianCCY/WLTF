//
//  Food.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import Foundation

struct FoodStorage: Hashable, Codable {
    var name: String
    var category: String
    var enterDate: Date
    var expireDate: Date
    var amount: Int
    var unit: String
}
