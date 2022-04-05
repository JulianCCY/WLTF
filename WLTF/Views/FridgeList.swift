//
//  UploadList.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI

struct FridgeList: View {
    var body: some View {
        List(foodArr, id: \.name) { food in
            FoodRow(food: food)
        }
    }
}

struct FridgeList_Previews: PreviewProvider {
    static var previews: some View {
        FridgeList()
    }
}
