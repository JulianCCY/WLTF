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
//    func addFood() {
//
//    }
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var category = ""
    @State private var amount = ""
    @State private var unit = ""
    @State private var expiryDate = Date()
    
    //            TextField("Food name", text: $name)
    //            TextField("Category", text: $category)
    //            TextField("Date of entry", text: $enterDate)
    //            TextField("Date of expiration", text: $expireDate)
    //            TextField("Amount", text: $amount)
    //            TextField("Unit", text: $unit)
    //            Button("Add food", action: addFood)
    
    var body: some View {
        VStack {
            // input form
            Form {
                Section {
                    TextField("Food name:", text: $name)
                    TextField("Category:", text: $category)
                    TextField("Amount:", text: $amount)
                    TextField("Unit:", text: $unit)
                    
                   
                    VStack {
                        DatePicker(selection: $expiryDate, in: Date.now.addingTimeInterval(86400)..., displayedComponents: .date) {
                                    Text("Select the expiry date:")
                                        .foregroundColor(.gray)
                                }
                    }
                    
                    HStack {
                        Spacer()
                        Button("Add") {
                            DataController().addFood(name: name,
                                                     category: category,
                                                     amount: Double(amount) ?? 0.0,
                                                     unit: unit ,
                                                     entryDate: formatting(currentDate: Date()),
                                                     expiryDate: expiryDate,
                                                     context: managedObjectContext)
                            dismiss()
                        }
                        Spacer()
                    }
                    .foregroundColor(.red)
                    
                }
            }
        }
//        .padding()
    }
}

struct AddFoodScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddFoodScreen()
    }
}

