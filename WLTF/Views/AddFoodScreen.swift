//
//  AddFoodScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI

struct AddFoodScreen: View {
    
    @State var name: String = ""
    @State var category: String = ""
    @State var enterDate: String = ""
    @State var expireDate: String = ""
    @State var amount: String = ""
    @State var unit: String = ""
    
    func addFood() {

    }
    
    var body: some View {
        VStack {
            TextField("Food name", text: $name)
            TextField("Category", text: $category)
            TextField("Date of entry", text: $enterDate)
            TextField("Date of expiration", text: $expireDate)
            TextField("Amount", text: $amount)
            TextField("Unit", text: $unit)
            Button("Add food", action: addFood)
        }
        .padding()
    }
}

struct AddFoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodScreen()
    }
}
