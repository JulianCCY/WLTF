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
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss

    @StateObject var globalArr = GlobalArr()
    
    var cates = ["Alcohol", "Bread", "Cooked", "Dairy", "Dessert", "Drinks", "Frozen", "Fruit", "Grain", "Meat", "Processed", "Protein", "Seasoning", "Seafood", "Snacks", "Vegetables", "Others"]
    var units = ["Bag(s)", "Bottle(s)", "Bowl(s)", "Box(es)", "Can(s)", "Cup(s)", "Pack(s)", "Piece(s)", "Plate(s)", "Pot(s)", "Serving(s)", "Milligram(s)", "Gram(s)", "Kiloram(s)", "Millilitre(s)", "Litre(s)", "Pound(s)", "Ounce(s)"]

    @State var name: String = ""
    @State var category: String = "Others"
    @State var expiryDate = Date.now.addingTimeInterval(86400)
    @State var amount: String = ""
    @State var unit: String = "Bags"
    
    @State private var alert = false
    @State private var alertMessage = ""
    
    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            globalArr.addFoodArr.remove(atOffsets: offsets)
        }
    }
    
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
                                    .keyboardType(.numberPad)
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
                        
                        Button {
                            if (name == "") {
                                alert = true
                                alertMessage = "Empty name"
                            } else if (Int(amount) == 0 || amount == "") {
                                alert = true
                                alertMessage = "Amount must be integer"
                            }
                            else {
                                globalArr.addFoodArr.append(FoodStruct(foodId: UUID(), name: name, category: category, entryDate: formatting(currentDate: Date()), expiryDate: expiryDate, amount: Double(amount) ?? 0, unit: unit))
                                
                                name = ""
                                category = "Others"
                                expiryDate = Date.now.addingTimeInterval(86400)
                                amount = ""
                                unit = "Bags"
                                hideKeyboard()
                            }
                        } label: {
                            Image(systemName: "plus.rectangle")
                                .font(.system(size: 20))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: 100, height: 20, alignment: .center)
                        .alert(isPresented: $alert) {
                            Alert(title: Text("Invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Ok")))
                        }
                        .foregroundColor(name == "" ? .gray : .blue)
                    }

                }
                Section {
                    ForEach(globalArr.addFoodArr, id: \.self) { i in
                        VStack {
                            HStack {
                                Text("Name:")
                                    .fontWeight(.semibold)
                                Text(i.name)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("Category:")
                                    .fontWeight(.semibold)
                                Text(i.category)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("Amount:")
                                    .fontWeight(.semibold)
                                Text("\(String(Int(i.amount))) \(i.unit)")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            HStack {
                                Text("Expiration:")
                                    .fontWeight(.semibold)
                                Text("\(formatting(currentDate: i.expiryDate))")
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding()
                        .listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity)
                        .background(
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 0)
                        )
                    }
                    .onDelete(perform: deleteItem)
                }
            }
            .listStyle(InsetListStyle())
            
            Button {
                if globalArr.addFoodArr.isEmpty == true {
                    alert = true
                    alertMessage = "The Adding List is Empty"
                    
                } else {
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
                }
                
            } label: {
                //button one
                Label("Confirm", systemImage: "checkmark")
            }
            .disabled(globalArr.addFoodArr.isEmpty)
            .alert(isPresented: $alert) {
                Alert(title: Text("Invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Ok")))
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

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
