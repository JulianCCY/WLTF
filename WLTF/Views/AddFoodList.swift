//
//  AddFoodList.swift
//  WLTF
//
//  Created by iosdev on 11.4.2022.
//

import SwiftUI

struct AddFoodList: View {

    @Environment(\.managedObjectContext) var managedObjectContext
//    var food: FoodStruct
    
    @StateObject var globalArr = GlobalArr()
    
    var cates = ["Alcohol", "Bread", "Cooked", "Dairy", "Desert", "Drinks", "Fruit", "Grain", "Protein", "Seasoning", "Seafood", "Veg", "Others"]
    var units = ["Bags", "Bottles", "Bowls", "Boxes", "Cans", "Cups", "Packs", "Pieces", "Plates", "Pots", "Milligrams", "Grams", "Kilorams", "Millilitre", "Litre", "Pound", "Ounce"]
    
    @State var name: String = ""
    @State var category: String = ""
    @State var enterDate = Date()
    @State var expireDate = Date()
    @State var amount: String = ""
    @State var amountInt: Int64 = 0
    @State var unit: String = ""

    var body: some View {
        VStack {
            HStack {
                TextField("Food name", text: $name)
                Spacer()
//                    .frame(width: 50)
                Picker("Category", selection: $category) {
                    ForEach(cates, id: \.self) {
                        Text($0)
                            .foregroundColor(.gray)
                    }
                }
                .pickerStyle(.menu)
                Spacer()
                    .frame(width: 50)
                Group {
                    TextField("Amount", text: $amount)
                        .frame(width: 70)
                    Picker("Unit", selection: $unit) {
                        ForEach(units, id: \.self) {
                            Text($0)
                                .foregroundColor(.gray)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(alignment: .leading)
                }
                .frame(width: 50, alignment: .trailing)
            }
            .padding([.top, .leading, .trailing])
            DatePicker("When will it expire?", selection: $expireDate, in: Date.now.addingTimeInterval(86400)..., displayedComponents: .date)
                .foregroundColor(.gray)
//                .datePickerStyle(WheelDatePickerStyle())
                .padding(.horizontal)
            
            // Button here can use dataController but can't append to global arr
        }
        .frame(maxWidth: .infinity, minHeight: 100)
        .border(.gray)
        
    }
    
    func returnName() -> String{
        return name
    }
}


struct AddFoodList_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodList()
    }
}

//        globalArr.addFoodArr.append(FoodStruct(name: name, category: category, entryDate: "", expiryDate: expireDate, amount: Double(amount) ?? 0.0, unit: unit))
//        print(globalArr.addFoodArr)
