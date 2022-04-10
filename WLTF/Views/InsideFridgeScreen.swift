//
//  InsideFridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI
import CoreData

struct InsideFridgeScreen: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.expiryDate, order: .reverse)]) var food:
        FetchedResults<Food>
    
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Text("\(Int(totalNumOfFood())) items")
                    .foregroundColor(.gray)
                    .padding(.horizontal)
                List {
                    ForEach(food) { food in
                        HStack {
                            VStack(alignment: .leading, spacing: 6) {
                                Text(food.foodName!)
                                    .bold()
                                
                                Text(food.category!) +
                                Text(" x \(Int(food.amount)) ") +
                                Text(food.unit!)
                            }
                            Spacer()
                            Text(calcExpiry(date:food.expiryDate!))
                                .foregroundColor(.brown)
                                .bold()
                        }
                    }
                    .onDelete(perform: deleteFood)
                    
                }
                .listStyle(.plain)
                
            }
            .navigationTitle("Food")
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Food", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodScreen()
            }
        }
        .navigationViewStyle(.stack)
    }
    
    private func totalNumOfFood() -> Int {
        return food.count
    }
    
    private func deleteFood(offsets: IndexSet) {
        withAnimation {
            offsets.map {food[$0]}.forEach(moc.delete)
            DataController().save(context: moc)
        }
    }

////needed
//    var categoryArr = Array(Set(foodArr.map{$0.category}))
//
//    let columns = [
//            GridItem(.adaptive(minimum: 80))
//        ]
//
//    var body: some View {
////        NavigationView {
//        VStack {
//            NavigationLink(destination: AddFoodScreen()) {
//                Text("Add food")
//            }
////            List(foodArr, id: \.self) { food in
////                NavigationLink {
////                    FoodDetail()
////                } label: {
////                    FoodRow(food: food)
////                }
////            }
//            List(categoryArr, id: \.self) { category in
//                Text("\(category)")
//                ScrollView {
//                    LazyVGrid(columns: columns, spacing: 20) {
//                        ForEach(foodArr.filter{$0.category == category}, id: \.self) { food in
//                            NavigationLink {
//                                FoodDetail()
//                            } label: {
//                                FoodGrid(food: food)
//                            }
//                        }
//                    }
//                    .padding(.horizontal)
//                }
//                .frame(maxHeight: 140)
//            }
//            .navigationBarTitle("All food")
////needed

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
//    }
}

struct InsideFridgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        InsideFridgeScreen()
    }
}
