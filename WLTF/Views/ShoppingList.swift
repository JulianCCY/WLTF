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
    
//    init() {
//        UITableView.appearance().sectionFooterHeight = 0
//    }
    
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
                List {
                    Section {
                        VStack {
                            HStack {
                                TextField("Food name", text: $foodName)
                                    .frame(width: 125)
                                Spacer()
                                TextField("Description (Optional)", text: $description)
                            }
                            .padding()
                            
                            Divider()
                            
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
                                    .font(.system(size: 20))
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .frame(width: 100, height: 20, alignment: .center)
                            .disabled(foodName == "")
                            .alert(isPresented: $alert) {
                                Alert(title: Text("Invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Ok")))
                            }
                            .foregroundColor(foodName == "" ? .gray : .blue)
                            Text("TO-BUY (\(toBuyArr.count))")
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Section {
                        ForEach(toBuyArr, id: \.self) { food in
                            VStack(alignment: .leading, spacing: 5) {
                                Text(food.foodName)
                                    .fontWeight(.bold)
                                    .font(.title2)
                                HStack {
                                    Text("Remark:")
                                        .fontWeight(.semibold)
                                    if (food.description == "") {
                                        Text("Nothing to show :)")
                                    } else {
                                        Text(food.description)
                                    }
                                }
                                if DataController().checkIfExist(foodName: food.foodName) == true {
                                    Text("still have")
                                } else{
                                    Text("dun have")
                                }
                            }
                            .padding()
                            .onTapGesture {
                            //update check status if user have put this food in the cart
                            DataController().updateCheckStatus(foodId: food.foodId, checked: food.checked as NSNumber)
                            toBuyArr = filterArr()
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
                }
                .listStyle(InsetListStyle())
                .onAppear { toBuyArr = filterArr() }
                
                NavigationLink(destination: MapView()) {
                    Image(systemName: "map")
                        .font(.system(size: 30))
                        .padding(10)
                        .frame(width: 50, height: 50)
                        .background(Color("PrimaryColor"))
                        .foregroundColor(Color.white)
                        .clipShape(Circle())
                        .contentShape(Circle())
                        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                }
                .background(.clear)
                Spacer()
            }
            .navigationTitle("Grocery List")
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
//        .navigationViewStyle(.stack)
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
