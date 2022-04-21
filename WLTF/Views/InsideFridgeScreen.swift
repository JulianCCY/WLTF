//
//  InsideFridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI
import CoreData
import Foundation

class GlobalArr: ObservableObject {
    @Published var addFoodArr: [FoodStruct] = []
    @Published var addToBuyArr: [ShoppingStruct] = []
}

struct InsideFridgeScreen: View {

    // Use Core Data in this file
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.expiryDate)]) var allFood: FetchedResults<Food>
    
//    @StateObject var globalArr = GlobalArr()
    @State var foodArr: [FoodStruct] = []
    
    @State private var alert = false
    @State private var alertMessage = ""
    
    init() {
        UITableView.appearance().backgroundColor = .white
    }

    private func filterArr() -> [FoodStruct] {
        foodArr = []
        DataController().fetchFoodData().forEach { i in
            foodArr.append(FoodStruct(foodId: i.id! ,name: i.name!, category: i.category!, entryDate: i.entryDate!, expiryDate: i.expiryDate!, amount: i.amount, unit: i.unit!))
        }
        // sort the food in each category by its expiryDate
//        foodArr.sort { (lhs: FoodStruct, rhs: FoodStruct) -> Bool in
//            return lhs.expiryDate < rhs.expiryDate
//        }
        return foodArr
    }
    
//    var categoryArr = Array(Set(globalArr.foodArr.map{$0.category}))
//
//    @State private var showingAddView = false

//    var categoryArr = Array(Set(globalArr.foodArr.map{$0.category}))

    let columns = [
            GridItem(.adaptive(minimum: 80))
        ]
    
    var body: some View {
//        NavigationView {
//                VStack(alignment: .leading) {
//                    Text("\(Int(totalNumOfFood())) item(s)")
//                        .foregroundColor(.gray)
//                        .padding(.horizontal)
//                    List {
//                        ForEach(filterCategory(arr: food.compactMap{$0.category}), id: \.self) { f in
//                            VStack {
//                                Text("\(f)")
//                                    .font(.headline)
//                            }
//                        }
//                    }
//                    .onAppear{
//                        foodArr = filterArr()
//                    }
//
//                    List {
//                        ForEach(foodArr, id: \.self) { item in
//                            HStack {
//                                VStack(alignment: .leading, spacing: 6) {
//                                    Text(item.name)
//
//                                    Text(item.category) +
//                                    Text(" x \(Int(item.amount)) ") +
//                                    Text(item.unit)
//                                    Text(item.entryDate)
//                                }
//                                Spacer()
//                                Text(calcExpiry(date: item.expireDate))
//                                    .foregroundColor(.brown)
//                            }
//                        }
//                    }
//                }
//                .navigationTitle("All Food")
//                .toolbar{
//                    ToolbarItem(placement: .navigationBarTrailing) {
//                        HStack {
//                            Button {
//                                showingAddView.toggle()
//                            } label: {
//                                Label("Add Food", systemImage: "plus.circle")
//                            }
//                            Button {
//                                DataController().deleteAllFood(context: moc)
//                            } label: {
//                                Label("Add Food", systemImage: "trash.circle")
//                            }
//                        }
//                    }
//                }
//                .sheet(isPresented: $showingAddView) {
//                    AddFoodScreen()
//                }
//            }
//            .navigationViewStyle(.stack)
//    }
    
    // count total num of food stored
//    private func totalNumOfFood() -> Int {
//            return food.count
//    }
    
    // delete the food and save afer delete
//    private func deleteFood(offsets: IndexSet) {
//        withAnimation {
//            offsets.map {food[$0]}.forEach(moc.delete)
//            DataController().save(context: moc)
//        }
//    }
    
//    private func filterCategory(arr: [String]) -> [String] {
//        if arr.isEmpty == true { return [] }
//        var dict = Set<String>()
//        var result: [String] = []
//        
//        for i in arr {
//            if dict.contains(i) == false {
//                dict.insert(i)
//                result.append(i)
//            }
//        }
//        return result
//    }
        VStack {
//            NavigationLink(destination: AddFoodScreen()) {
//                // Navigate to add food screen
//                Label("Add food into fridge", systemImage: "plus")
//            }
//            Array(Set(foodArr.map{$0.category}))
            
            //ghost of codewar again
            // we can sort category by expiryDate and sort the food in each category by expiryDate
            List(NSOrderedSet(array: foodArr.map{$0.category}).map({$0 as! String}), id: \.self) { category in
                VStack {
                    Text("\(category)")
                        .font(.headline)
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(foodArr.filter{$0.category == category}, id: \.self) { food in
                                NavigationLink {
                                    FoodDetail(food: food)
                                }
                                label: {
                                    FoodGrid(food: food)
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 110)
                }
            }
            // Screen Header / title
            .navigationBarTitle("All food")
            .onAppear{
                foodArr = filterArr()
            }
            HStack {
                Spacer()
                NavigationLink(destination: AddFoodScreen()) {
                    // Navigate to add food screen
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("PrimaryColor"))
                        .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                        .padding(.trailing)
                }
            }
            .background(.clear)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                // Top Right delete button
                Button {
                    alert = true
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .alert("This action will empty your fridge!", isPresented: $alert) {
                    Button("Crystal clear", role: .destructive) {
                        DataController().deleteAllFood(context: moc)
                        moc.refreshAllObjects()
                        foodArr = []
                    }
                    Button("Cancel", role: .cancel) { }
                }
                .disabled(foodArr.isEmpty)
            }
        }
    }
}

struct InsideFridgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        InsideFridgeScreen()
    }
}

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}
