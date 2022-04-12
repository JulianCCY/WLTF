//
//  AddFoodScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI

class GlobalArr: ObservableObject {
  @Published var addFoodArr: [FoodStorage] = []
}

struct AddFoodScreen: View {
    
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
    
    func addFood() {

    }
    
    var body: some View {
        VStack {
//            ScrollView {
                List(globalArr.addFoodArr, id: \.self) { food in
                    AddFoodList()
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(GroupedListStyle())
//            }
            Button {
                addFood()
            } label: {
                Label("Add food", systemImage: "plus")
            }
        }
        .navigationBarTitle("Add food")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    globalArr.addFoodArr.append(FoodStorage(name: "", category: "", entryDate: "", expiryDate: "", amount: 0, unit: ""))
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
//    }
}

    struct AddFoodScreen_Previews: PreviewProvider {
        static var previews: some View {
            AddFoodScreen()
        }
    }
}
