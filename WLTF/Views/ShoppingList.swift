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
    
    // for upload input
    @State private var foodName = ""
    @State private var description = ""
    
    // for edit input
    @State private var itemName = ""
    @State private var itemDetails = ""
    @State private var itemId = ""
    
    // for general alert
    @State private var alert = false
    @State private var deleteAlert = false
    @State private var editAlert = false
    @State private var alertMessage = ""
    @State private var disabled = true
    
    private func selectColour(checked: Bool) -> String {
        if (checked) {
            return "CheckedItem"
        } else {
            return "NormalItem"
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ZStack {
                    VStack() {
                        List {
                            Section {
                                VStack {
                                    HStack {
                                        TextField("Food name", text: $foodName)
                                            .frame(width: 125)
        //                                    .border(Color.black, width: 1, cornerRadius(5))
                                        Spacer()
                                        TextField("Description (Optional)", text: $description)
                                    }
        //                            .overlay(
        //                                Capsule(style: .continuous)
        //                                    .stroke(Color.purple, style: StrokeStyle(lineWidth: 1))
        //                                    )
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
                                    
                                    Divider()
                                    
                                    VStack(alignment: .leading) {
                                        Label {
                                            Text("Detected similar food remaining in fridge")
                                        } icon: {
                                            Image(systemName: "exclamationmark.square")
                                                .foregroundColor(Color("SecondaryColor"))
                                        }
                                        .font(.system(size: 12))
                                        Label {
                                            Text("Double tab to check your item")
                                        } icon: {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.green)
                                        }
                                        .font(.system(size: 12))
    //                                    Label("Detected similar food remaining in fridge", systemImage: "exclamationmark.square")
    //                                    Label("Double tab to check your item", systemImage: "checkmark")
                                    }
                                }
                            }
                            
                            Section {
                                ForEach(toBuyArr, id: \.self) { food in
                                    ZStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(food.foodName)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            Text("Remark:")
                                                .fontWeight(.semibold)
                                            HStack {
                                                if (food.description == "") {
                                                    Text("Nothing to show :)")
                                                } else {
                                                    Text(food.description)
                                                        .lineLimit(nil)
                                                        .multilineTextAlignment(.leading)
                                                }
                                                Spacer()
                                            }
                                        }
                                        if (food.checked) {
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    VStack {
                                                        Image(systemName: "checkmark")
                                                            .foregroundColor(Color.green)
                                                    }
                                                }
                                                Spacer()
                                            }
                                        }
                                        else if DataController().checkIfExist(foodName: food.foodName) == true {
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Image(systemName: "exclamationmark.square")
                                                        .foregroundColor(Color("SecondaryColor"))
                                                }
                                                Spacer()
                                            }
                                        }
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .contentShape(Rectangle())
                                    .highPriorityGesture(
                                          TapGesture(count:2)
                                            .onEnded({
                                                //update check status if user have put this food in the cart
                                                DataController().updateCheckStatus(foodId: food.foodId, checked: food.checked as NSNumber)
                                                toBuyArr = filterArr()                                    })
                                        )
                                    .onTapGesture{}.onLongPressGesture(minimumDuration: 0.5) {
                                        editAlert = true
                                        itemName = food.foodName
                                        itemDetails = food.description
                                        itemId = food.foodId.uuidString
                                    }
                                    .background(Color(selectColour(checked: food.checked)))
                                    .cornerRadius(10)
                                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
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
                    }
                    .navigationTitle("Grocery List")
                    .toolbar{
                        ToolbarItem(placement: .navigationBarTrailing) {
                            Button {
                                deleteAlert = true
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                            .alert("Empty your grocery list?", isPresented: $deleteAlert) {
                                Button("Yes please", role: .destructive) {
                                    DataController().removeWholeList(context: moc)
                                    toBuyArr = []
                                }
                                Button("Noooooooo", role: .cancel) { }
                            }
                            .disabled(toBuyArr.isEmpty)
                        }
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
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
                        }
                        .padding([.trailing, .bottom])
                    }
                }.blur(radius: editAlert ? 20 : 0)
                if editAlert {
                    EditAlert(itemName: $itemName, itemDetails: $itemDetails, showingAlert: $editAlert, itemId: $itemId)
                }
//          Big Zstack
            }
//          Navigation
        }
//        .navigationViewStyle(.stack)
        .navigationTitle("")
        .navigationBarHidden(true)
        
        
        
    }
    
    func filterArr() -> [ShoppingStruct] {
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
