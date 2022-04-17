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
//    @State var name: String = ""
//    @State var category: String = ""
//    @State var enterDate: String = ""
//    @State var expireDate: String = ""
//    @State var amount: String = ""
//    @State var unit: String = ""
//
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
  
    @State var globalArr = GlobalArr()
    @State var listView: [AddFoodList] = []
    @State var sth = [Any]()
//
//    @Environment(\.managedObjectContext) var context
//    @Environment(\.dismiss) var dismiss
//
//    @State var name: String = ""
//    @State var category: String = ""
//    @State var enterDate = Date()
//    @State var expireDate = Date()
//    @State var amount: String = ""
//    @State var amountInt: Int64 = 0
//    @State var unit: String = ""
    
    @State private var name = ""
    @State private var category = ""
    @State private var expiryDate = Date()
    @State private var amount = ""
    @State private var unit = ""

    @State private var numOfForm = 0
    
    var body: some View {
        VStack {
//            List((0...numOfForm), id: \.self) { food in
//                AddFoodList()
//                    .listRowInsets(EdgeInsets())
//            }
//            .listStyle(GroupedListStyle())
            
            List(listView, id: \.name) { v in
                v
                    .listRowInsets(EdgeInsets())
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
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Button here can append to global arr but can't relate to addFoodList()
                    listView.append(AddFoodList())
                    numOfForm += 1
//                    globalArr.addFoodArr.append(FoodStruct(name: name, category: category, entryDate: "", expiryDate: expiryDate, amount: 0.0, unit: unit))
                } label: {
                    // Top right add new form
                    Label("Add new form", systemImage: "plus.circle")
                }
            }
        }
        
        
//        VStack {
//            TextField("Food name", text: $name)
//            TextField("Category", text: $category)
//            DatePicker("Entry date", selection: $enterDate, displayedComponents: .date)
//            DatePicker("Expire date", selection: $expireDate, displayedComponents: .date)
//            TextField("Amount", text: $amount)
//            TextField("Unit", text: $unit)
//            Button("Add food") {
//                amountInt = Int64(amount) ?? 0
//                FoodDataController().addFood(
//                    name: name,
//                    category: category,
//                    enterDate: enterDate,
//                    expireDate: expireDate,
//                    amount: amountInt,
//                    unit: unit ,
//                    context: context)
//                dismiss()
//            }
//            Spacer()
//            Button {
//                addFood()
//            } label: {
//                Label("Add food", systemImage: "plus")
//            }
//        }
//        .padding()
        
//        VStack {
//            Form {
//                Section {
//                    TextField("Food name:", text: $name)
//                    TextField("Category:", text: $category)
//                    TextField("Amount:", text: $amount)
//                    TextField("Unit:", text: $unit)
//                    VStack {
//                        DatePicker(selection: $expiryDate, in: Date.now.addingTimeInterval(86400)..., displayedComponents: .date) {
//                                    Text("Select the expiry date:")
//                                        .foregroundColor(.gray)
//                                }
//                    }
//                    HStack {
//                        Spacer()
//                        Button("Add") {
//                            DataController().addFood(name: name,
//                                                     category: category,
//                                                     amount: Double(amount) ?? 0.0,
//                                                     unit: unit ,
//                                                     entryDate: formatting(currentDate: Date()),
//                                                     expiryDate: expiryDate,
//                                                     context: managedObjectContext)
//                            dismiss()
//                        }
//                        Spacer()
//                    }
//                }
//            }
//        }
    }
    
}

struct AddFoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodScreen()
    }
}

