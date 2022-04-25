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
//        if #available(iOS 15, *) {
//            UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
//        }
//    }
    
//    init() {
//            UITabBar.appearance().backgroundColor = UIColor.white
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
                    VStack {
//                        Text("Grocery list")
//                            .font(.title)
//                            .fontWeight(.bold)
//                            .padding([.top, .leading])
//                            .frame(maxWidth: .infinity, alignment: .leading)
//                            .navigationTitle("")
//                            .navigationBarHidden(true)
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
                                            Text("Note:")
                                                .fontWeight(.semibold)
                                                .padding(.top, 5)
                                            HStack {
                                                if (food.description == "") {
                                                    Text("Blank")
                                                        .font(.subheadline)
                                                        .foregroundColor(.black)
                                                } else {
                                                    Text(food.description)
                                                        .font(.subheadline)
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
                                    .listRowSeparator(.hidden)
                                    .frame(maxWidth: .infinity)
                                    .contentShape(Rectangle())
                                    .highPriorityGesture(
                                          TapGesture(count:2)
                                            .onEnded({
                                                //update check status if user have put this food in the cart
                                                DataController().updateCheckStatus(foodId: food.foodId, checked: food.checked as NSNumber)
                                                toBuyArr = filterArr()})
                                        )
                                    .onTapGesture{}.onLongPressGesture(minimumDuration: 0.3) {
                                        // edit item details
                                        editAlertView(oldName: food.foodName, oldDescr: food.description, itemId: food.foodId.uuidString)
                                    }
                                    .background(Color(selectColour(checked: food.checked)))
                                    .cornerRadius(10)
//                                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                                    .shadow(color: Color.gray.opacity(0.4), radius: 3, x: 0, y: 0)
                                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                        Button(role: .destructive){
                                            withAnimation(.default){
                                                let uuid =  food.foodId
                                                DataController().removeSingleItem(id: uuid, context: moc)
                                                toBuyArr = filterArr()
                                            }
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }
                                    }
                                }
//                                .onDelete {
//                                    offset in
//                                    // ghost of codewars
//                                    let uuid =  offset.compactMap{toBuyArr[$0].foodId}[0]
//                                    DataController().removeSingleItem(id: uuid, context: moc)
//                                    toBuyArr = filterArr()
//                                }
                                
                                
                            }
                        }
                        .navigationBarTitle("Grocery List")
                        .listStyle(InsetListStyle())
                        .onAppear { toBuyArr = filterArr() }
                    }
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
                                    .cornerRadius(6)
                                    .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                            }
                        }
                        .padding([.trailing, .bottom])
                    }
                }.blur(radius: editAlert ? 20 : 0)
    //          Big Zstack
            }
//       navigation
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        
    }
    
    // transform objects to useable array
    func filterArr() -> [ShoppingStruct] {
        toBuyArr = []
        DataController().fetchShoppingData().forEach { i in
            toBuyArr.append(ShoppingStruct(foodId: i.id!, foodName: i.name!, description: i.details!, checked: i.checked?.boolValue ?? false))
        }
        return toBuyArr
    }
    
    // alert edit view to edit info of item
    func editAlertView(oldName: String, oldDescr: String, itemId: String) {
        let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene
        
//        let editAlert = UIAlertController(title: "Error", message: "Food name can't be Empty", preferredStyle: .alert)
        
        let alert = UIAlertController(title: "Edit", message: "please input new food name and description", preferredStyle: .alert)
        alert.addTextField { foodName in
            foodName.placeholder = "\(oldName)"
            alert.textFields![0].text! = oldName
        }
        
        alert.addTextField { description in
            description.placeholder = "Description (Optional)"
            alert.textFields![1].text! = oldDescr
        }
        
        let submitEdit = UIAlertAction(title: "Confirm", style: .default) { (_) in
            itemName = alert.textFields![0].text! == "" ? oldName : alert.textFields![0].text!
            itemDetails = alert.textFields![1].text! == "" ? "" : alert.textFields![1].text!
            
            DataController().updateShoppingListItem(foodId: itemId, foodName: itemName, description: itemDetails)
            toBuyArr = filterArr()
        }
        
        let cancelEdit = UIAlertAction(title: "Cancel", style: .destructive) { (_) in }
        
        alert.addAction(submitEdit)
        alert.addAction(cancelEdit)
        
        screen!.windows.first?.rootViewController?.present(alert, animated: true,
            completion: {
                itemName = ""
                itemDetails = ""
        })
        
    }
}

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingList()
    }
}
