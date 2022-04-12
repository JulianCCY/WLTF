//
//  InsideFridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI
import CoreData
import Foundation

struct InsideFridgeScreen: View {
    
    // Use Core Data in this file
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.expiryDate)]) var food: FetchedResults<Food>
    
    @State var foodArr: [FoodStruct] = []
    
    init() {
        foodArr = filterArr()
    }
    
    @State private var showingAddView = false

//    var categoryArr = Array(Set(foodArr.map{$0.category}))
//
//    let columns = [
//            GridItem(.adaptive(minimum: 80))
//        ]
    
    var body: some View {
        NavigationView {
                VStack(alignment: .leading) {
                    Text("\(Int(totalNumOfFood())) item(s)")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    List {
                        ForEach(filterCategory(arr: food.compactMap{$0.category}), id: \.self) { f in
                            VStack {
                                Text("\(f)")
                                    .font(.headline)
                            }
                        }
                    }
                    
                    .onAppear{
                        foodArr = filterArr()
                    }
                    
                    List {
                        ForEach(foodArr, id: \.self) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(item.name)

                                    Text(item.category) +
                                    Text(" x \(Int(item.amount)) ") +
                                    Text(item.unit)
                                    
                                    Text(item.entryDate)
                                }
                                Spacer()
                                Text(calcExpiry(date: item.expireDate))
                                    .foregroundColor(.brown)
                            }
                        }
                            
                    }
                    
//                    List {
//                        ForEach(food) { food in
//                            HStack {
//                                NavigationLink(destination: FoodDetail()) {
//                                VStack(alignment: .leading, spacing: 6) {
//                                    Text(food.name!)
//                                        .bold()
//
//                                    Text(food.category!) +
//                                    Text(" x \(Int(food.amount)) ") +
//                                    Text(food.unit!)
//                                }
//                                Spacer()
//                                Text(calcExpiry(date:food.expiryDate!))
//                                    .foregroundColor(.brown)
//                                }
//                            }
//                        }
//                        .onDelete(perform: deleteFood)
//
//                    }
//                    .listStyle(.plain)
                    
                }
                .navigationTitle("All Food")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        HStack {
                            Button {
                                showingAddView.toggle()
                            } label: {
                                Label("Add Food", systemImage: "plus.circle")
                            }
                            Button {
                                DataController().deleteAllFood(context: moc)
                            } label: {
                                Label("Add Food", systemImage: "trash.circle")
                            }
                        }
                    }
                }
                .sheet(isPresented: $showingAddView) {
                    AddFoodScreen()
                }
            }
            .navigationViewStyle(.stack)
    }
    
    // count total num of food stored
    private func totalNumOfFood() -> Int {
            return food.count
    }
    
    // delete the food and save afer delete
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map {food[$0]}.forEach(moc.delete)
            DataController().save(context: moc)
        }
    }
    
    private func filterCategory(arr: [String]) -> [String] {
        if arr.isEmpty == true { return [] }
        var dict = Set<String>()
        var result: [String] = []
        
        for i in arr {
            if dict.contains(i) == false {
                dict.insert(i)
                result.append(i)
            }
        
        }
        
        return result
    }
    
    
    
                                
    struct FoodStruct: Hashable {
        var name: String
        var category: String
        var entryDate: String
        var expireDate: Date
        var amount: Double
        var unit: String
    }

    private func filterArr() -> [FoodStruct] {
        foodArr = []
        food.forEach { i in
            foodArr.append(FoodStruct(name: i.name!, category: i.category!, entryDate: i.entryDate!, expireDate: i.expiryDate!, amount: i.amount, unit: i.unit!))
        }
        print(foodArr)
//        for i in food {
//            foodArr.append(FoodStruct(name: i.name!, category: i.category!, expireDate: i.expiryDate!, amount: i.amount, unit: i.unit!))
//        }
        return foodArr
    }
    
//    var body: some View {
//        NavigationView {
//        VStack {
//            NavigationLink(destination: AddFoodScreen()) {
//                Text("Add food")
//            }
//            List(foodArr, id: \.self) { food in
//                NavigationLink {
//                    FoodDetail()
//                } label: {
//                    FoodRow(food: food)
//                }
//            }
//            List(categoryArr, id: \.self) { category in
//                VStack {
//                    Text("\(category)")
//                        .font(.headline)
//                    ScrollView {
//                        LazyVGrid(columns: columns, spacing: 20) {
//                            ForEach(foodArr.filter{$0.category == category}, id: \.self) { food in
//                                NavigationLink {
//                                    FoodDetail(food: food)
//                                }
//                                label: {
//                                    FoodGrid(food: food)
//                                }
//                                .buttonStyle(PlainButtonStyle())
//                            }
//                        }
//                        .padding(.horizontal)
//                    }
//                    .frame(maxHeight: 200)
//                }
//            }
//            .navigationBarTitle("All food")
//            ScrollView {
//                LazyVGrid(columns: columns, spacing: 20) {
//                    ForEach(foodArr, id: \.self) { food in
//                        NavigationLink {
//                            FoodDetail()
//                        } label: {
//                            FoodGrid(food: food)
//                        }
//                    }
//                }
//                .padding(.horizontal)
//            }
//            .frame(maxHeight: 230)
//            .navigationBarTitle("All food")
//        }
//        }
//    }
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
