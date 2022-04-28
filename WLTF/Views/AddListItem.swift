//
//  AddListItem.swift
//  WLTF
//
//  Created by iosdev on 12.4.2022.
//

import SwiftUI

struct AddListItem: View {
    
    @StateObject var globalArr = GlobalArr()
    
    var body: some View {
        HStack {
            Button {
                globalArr.addFoodArr.append(contentsOf: [])
            } label: {
                Label("Add food", systemImage: "plus")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .border(.gray)
    }
}

struct AddListItem_Previews: PreviewProvider {
    static var previews: some View {
        AddListItem()
    }
}
