//
//  AddFoodScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI
import Foundation
import CoreData

struct AddFoodScreen: View {

    @StateObject var globalArr = GlobalArr()
    
    var cates = ["Alcohol", "Bread", "Cooked", "Dairy", "Desert", "Drinks", "Fruit", "Grain", "Protein", "Seasoning", "Seafood", "Veg", "Others"]
    var units = ["Bags", "Bottles", "Bowls", "Boxes", "Cans", "Cups", "Packs", "Pieces", "Plates", "Pots", "Milligrams", "Grams", "Kilorams", "Millilitre", "Litre", "Pound", "Ounce"]

    @State var name: String = ""
    @State var category: String = "Others"
    @State var expiryDate = Date()
    @State var amount: String = ""
    @State var unit: String = "Bags"
    
    var body: some View {
        VStack {
            List {
                Section {
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
                        DatePicker("When will it expire?", selection: $expiryDate, in: Date.now.addingTimeInterval(86400)..., displayedComponents: .date)
                            .foregroundColor(.gray)
            //                .datePickerStyle(WheelDatePickerStyle())
                            .padding(.horizontal)
                        
                        Divider()
                        
                        Button("Insert") {                                    globalArr.addFoodArr.append(FoodStruct(name: name, category: category, entryDate: formatting(currentDate: Date()), expiryDate: expiryDate, amount: Double(amount) ?? 0, unit: unit))
                            
                            name = ""
                            category = "Others"
                            expiryDate = Date()
                            amount = ""
                            unit = "Bags"
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: 100, height: 30, alignment: .center)
                    }

                }
                Section {
                    ForEach(globalArr.addFoodArr, id: \.self) { i in
                        VStack {
                            HStack {
                                Text(i.name)
                                Text(i.category)
                                Text(String(Int(i.amount)))
                                Text(i.unit)
                            }
                            Text("Expiry date: \(formatting(currentDate: i.expiryDate))")
                        }
                    }
                }
            }
            .listStyle(GroupedListStyle())
            
            Button {
                globalArr.addFoodArr = []
                print(listView[0].name)
//                listView.forEach{ i in
//                    globalArr.addFoodArr.append(FoodStruct(name: i.name, category: i.category, entryDate: "", expiryDate: i.expireDate, amount: 10.0, unit: "boxes"))
//                }
//                print(globalArr.addFoodArr)
                globalArr.addFoodArr.forEach { item in
                    DataController().addFood(name: item.name,
                                             category: item.category,
                                             amount: Double(item.amount),
                                             unit: item.unit ,
                                             entryDate: formatting(currentDate: Date()),
                                             expiryDate: item.expiryDate,
                                             context: managedObjectContext)
                }
                dismiss()
            } label: {
                //button one
                Label("Add food", systemImage: "plus")
            }
        }
        // Screen Title
        .navigationBarTitle("Add food")
        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
////                    globalArr.addFoodArr.append(FoodStruct(name: "", category: "", entryDate: "", expiryDate: Date(), amount: 0, unit: ""))
//                    arr.append(x)
//                    x += 1
//                } label: {
//                    Label("Add Food", systemImage: "plus.circle")
//                }
//            }
        }
    }
    
}

struct AddFoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodScreen()
    }
}

