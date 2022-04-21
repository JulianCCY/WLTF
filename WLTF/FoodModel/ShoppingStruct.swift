//
//  ShoppingStruct.swift
//  WLTF
//
//  Created by Chan Chung Yin on 19/4/2022.
//

import Foundation

struct ShoppingStruct: Hashable, Codable {
    var foodId: UUID
    var foodName: String
    var description: String
    var checked: Bool
}
