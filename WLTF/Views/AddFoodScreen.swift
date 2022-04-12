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
    func addFood() {

    }
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
  
    @StateObject var globalArr = GlobalArr()
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
    
    var body: some View {
        VStack {
            List(globalArr.addFoodArr, id: \.self) { food in
                AddFoodList()
                    .listRowInsets(EdgeInsets())
            }
            .listStyle(GroupedListStyle())
            Button {
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
                Label("Add food", systemImage: "plus")
            }
        }
        .navigationBarTitle("Add food")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    globalArr.addFoodArr.append(FoodStruct(name: "", category: "", entryDate: "", expiryDate: Date(), amount: 0, unit: ""))
                    print(globalArr.addFoodArr)
                } label: {
                    Label("Add Food", systemImage: "plus.circle")
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

