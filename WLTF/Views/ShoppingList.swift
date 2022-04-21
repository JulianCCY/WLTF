//
//  ShoppingList.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//

import SwiftUI
import Foundation
import CoreData
import MapKit

struct ShoppingList: View {
    
    // access coredata in this file
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
//    @FetchRequest(sortDescriptors: []) var toBuyItems: FetchedResults<Shopping>
    
    // need to the shopping struct restructure the array then I sin can use
    @State var toBuyArr: [ShoppingStruct] = []
    
    @State private var foodName = ""
    @State private var description = ""
    
    @State private var alert = false
    @State private var alertMessage = ""
    @State private var disabled = true
    
    var body: some View {
        NavigationView {
            VStack() {
//                NavigationLink(destination: AddToBuyScreen()) {
//                    Label("Edit", systemImage: "plus")
//                }
                
                Section {
                    HStack {
                        Group {
                            Spacer()
                            TextField("Food name", text: $foodName)
    //                            .frame(width: 50)
                            Spacer()
                            TextField("Description (Optional)", text: $description)
                        }
                    }
                    Divider()
                    Spacer()
                    Button() {
                        if foodName == "" {
                            alert = true
                            alertMessage = "Empty Food name"
                        } else {
                            DataController().addToBuy(name: foodName, descr: description, context: moc)
                            toBuyArr = filterArr()
                            foodName = ""
                            description = ""
                        }
                    } label: {
                        Image(systemName: "plus.rectangle")
                    }
                    .disabled(foodName == "")
                    .alert(isPresented: $alert) {
                        Alert(title: Text("Invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Ok")))
                    }
                    .foregroundColor(foodName == "" ? .gray : .red)
                    Spacer()
                }
                
                Text("TO-BUY (\(toBuyArr.count))")
                    .foregroundColor(.gray)
                List{
                    ForEach(toBuyArr, id: \.self) { food in
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text(food.foodName)
                                    .bold()
                                Text(food.description)
                                HStack {
                                    Text(String(food.checked))
                                }
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .onTapGesture {
                            print(food.foodId)
//                            DataController().checkFridgeContains(foodName: food.foodName)
                        }
                    }
                    .onDelete {
                        offset in
                            // ghost of codewars
                        let uuid =  offset.compactMap{toBuyArr[$0].foodId}[0]
                        DataController().removeSingleItem(id: uuid, context: moc)
                        toBuyArr = filterArr()
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Grocery List")
                .onAppear { toBuyArr = filterArr() }
                
                NavigationLink(destination: MapView()) {
                    Image(systemName: "map")
                        .font(.system(size: 30))
                        .padding(10)
                        .background(Color("BackgroundColor"))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .contentShape(Circle())
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        DataController().removeWholeList(context: moc)
                        toBuyArr = []
                    } label: {
                        Label("", systemImage: "trash")
                    }
                    .disabled(toBuyArr.isEmpty)
                }
            }
        }
        .navigationViewStyle(.stack)
        .navigationTitle("")
        .navigationBarHidden(true)
        
        
        
    }
    
    private func filterArr() -> [ShoppingStruct] {
        toBuyArr = []
        DataController().fetchShoppingData().forEach { i in
            toBuyArr.append(ShoppingStruct(foodId: i.id!, foodName: i.name!, description: i.details!, checked: i.checked?.boolValue ?? false))
        }
        return toBuyArr
    }
}

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingList()
    }
}
