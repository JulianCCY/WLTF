//
//  ShoppingList.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//
// This is the shopping list, renamed to grocery list in our app
// This screen is one of the three screens that can be navigated from tab view
// User can add items to their grocery list, reminding them what to buy in the market
// User can edit their items by holding the item
// User can check or uncheck the item by double tapping
// This screen can navigate to map view to find nearby markets
// Mapview implemented

import SwiftUI
import Foundation
import CoreData
import MapKit

struct ShoppingList: View {
    
    // access coredata in this file
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
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
//    @State private var editAlert = false
    @State private var alertMessage = ""
    @State private var disabled = true
    
    private func selectColour(checked: Bool) -> String {
        if (checked) {
            return "CheckedItem"
        } else {
            return "BackgroundColor"
        }
    }
    
    var body: some View {
            ZStack {

                Color("TertiaryColor")
                    .ignoresSafeArea()
                
                    VStack {
                        VStack {
                            HStack {
                                Text("grocery_list")
                                    .font(.system(size: 36))
                                    .fontWeight(.bold)
                                    .padding(.top, 50)
                                    .padding(.leading, 20)
                                Spacer()
                            }
                        }

                        List {
                            Section {
                                VStack {
                                    HStack {
                                        TextField("food_name", text: $foodName)
                                            .frame(width: 125)
                                        Spacer()
                                        TextField("description", text: $description)
                                    }
                                    .padding()
                                    
                                    Divider()
                                    
                                    Button() {
                                        if foodName == "" {
                                            alert = true
                                            alertMessage = "empty_food_name"
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
                                        Alert(title: Text("invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("ok")))
                                    }
                                    .foregroundColor(foodName == "" ? .gray : Color("PrimaryColor"))
                                    
                                    Text("to_buy (\(toBuyArr.count))")
                                    
                                    Divider()
                                    
                                    VStack(alignment: .leading) {
                                        Label {
                                            Text("detected")
                                        } icon: {
                                            Image(systemName: "exclamationmark.square")
                                                .foregroundColor(Color("PrimaryColor"))
                                        }
                                        .font(.system(size: 12))
                                        Label {
                                            Text("double_tab")
                                        } icon: {
                                            Image(systemName: "checkmark")
                                                .foregroundColor(Color.green)
                                        }
                                        .font(.system(size: 12))
                                    }
                                }
                                .listRowBackground(Color("TertiaryColor"))
                            } // section
                            
//                            displaying list
                            Section {
                                ForEach(toBuyArr, id: \.self) { food in
                                    ZStack {
                                        VStack(alignment: .leading, spacing: 5) {
                                            Text(food.foodName)
                                                .fontWeight(.bold)
                                                .font(.title2)
                                            Text("note:")
                                                .fontWeight(.semibold)
                                                .padding(.top, 5)
                                            HStack {
                                                if (food.description == "") {
                                                    Text("blank")
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
                                    .listRowBackground(Color("TertiaryColor"))
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
                                        // edit item details by alert
                                        editAlertView(oldName: food.foodName, oldDescr: food.description, itemId: food.foodId.uuidString)
                                    }
                                    .background(Color(selectColour(checked: food.checked)))
                                    .cornerRadius(10)
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
                            }
                        }
                        .listStyle(InsetListStyle())
                        .onAppear { toBuyArr = filterArr() }
                    }

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            NavigationLink(destination: MapScreen()) {
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
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                deleteAlert = true
                            } label: {
                                Image(systemName: "trash")
                                    .font(.system(size: 22))
                                    .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 15))
                            }
                            .alert("empty_grocery_list?", isPresented: $deleteAlert) {
                                Button("yes_please", role: .destructive) {
                                    DataController().removeWholeList(context: moc)
                                    toBuyArr = []
                                }
                                Button("cancel", role: .cancel) { }
                            }
                            .disabled(toBuyArr.isEmpty)
                        }
                        Spacer()
                    }
    //          Big Zstack
            }
//       navigation title
        .navigationTitle("")
        .navigationBarHidden(true)
        .environment(\.locale, .init(identifier: UserDefaults.standard.string(forKey: "lang") ?? "en"))
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
        
        let alert = UIAlertController(title: "\(translateTitle(input: UserDefaults.standard.string(forKey: "lang") ?? "en"))", message: "\(translateEdit(input: UserDefaults.standard.string(forKey: "lang") ?? "en"))", preferredStyle: .alert)
        alert.addTextField { foodName in
            foodName.placeholder = "\(oldName)"
            alert.textFields![0].text! = oldName
        }
        
        alert.addTextField { description in
            description.placeholder = "\(translateDescription(input: UserDefaults.standard.string(forKey: "lang") ?? "en"))"
            alert.textFields![1].text! = oldDescr
        }
        
        let submitEdit = UIAlertAction(title: "\(translateConfirm(input: UserDefaults.standard.string(forKey: "lang") ?? "en"))", style: .default) { (_) in
            itemName = alert.textFields![0].text! == "" ? oldName : alert.textFields![0].text!
            itemDetails = alert.textFields![1].text! == "" ? "" : alert.textFields![1].text!
            
            DataController().updateShoppingListItem(foodId: itemId, foodName: itemName, description: itemDetails)
            toBuyArr = filterArr()
        }
        
        let cancelEdit = UIAlertAction(title: "\(translateCancel(input: UserDefaults.standard.string(forKey: "lang") ?? "en"))", style: .destructive) { (_) in }
        
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

// Functions for translating the strings in edit alert...

//    environment locale cannot localize edit alert, that's why we need a funcition
private func translateTitle(input: String) -> String {
    if input == "fi" {
        return "Muokata"
    }
    else {
        return "Edit"
    }
}

private func translateEdit(input: String) -> String {
    if input == "fi" {
        return "Syötä uusi ruoan nimi ja kuvaus"
    }
    else {
        return "Please input new food name and description"
    }
}

private func translateDescription(input: String) -> String {
    if input == "fi" {
        return "Kuvaus (Valinnainen)"
    }
    else {
        return "Description (Optional)"
    }
}

private func translateConfirm(input: String) -> String {
    if input == "fi" {
        return "Vahvistaa"
    }
    else {
        return "Confirm"
    }
}

private func translateCancel(input: String) -> String {
    if input == "fi" {
        return "Peruuttaa"
    }
    else {
        return "Cancel"
    }
}
