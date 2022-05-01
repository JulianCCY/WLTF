//
//  InsideFridgeScreen.swift
//  WLTF
//
//  Created by iosdev on 6.4.2022.
//

import SwiftUI
import CoreData
import Foundation
import AVFoundation

class GlobalArr: ObservableObject {
    @Published var addFoodArr: [FoodStruct] = []
    @Published var addToBuyArr: [ShoppingStruct] = []
}

struct InsideFridgeScreen: View {

    // Use Core Data in this file
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.expiryDate)]) var allFood: FetchedResults<Food>
    
//    @StateObject var globalArr = GlobalArr()
    @State var foodArr: [FoodStruct] = []
    
    @State private var alert = false
    @State private var alertMessage = ""
    
    @State private var searchText = ""
    
    var searchResult: [FoodStruct] {
        if searchText.isEmpty {
            return foodArr
        } else {
            return foodArr.filter{ $0.name.contains(searchText)}
        }
    }
    
    init() {
        UITableView.appearance().backgroundColor = .white
    }
    
    func playSound() {
        var filePath: String?
        filePath = Bundle.main.path(forResource: "close-fridge", ofType: "mp3") 
        let fileURL = URL(fileURLWithPath: filePath!)
        var soundID:SystemSoundID = 0
        AudioServicesCreateSystemSoundID(fileURL as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        if self.isMovingFromParent {
//            playSound()
//        }
//    }
    // fetching data from the coredata
    private func filterArr() -> [FoodStruct] {
        foodArr = []
        // finished expiry date sorting in DataController
        DataController().fetchFoodData().forEach { i in
            foodArr.append(FoodStruct(foodId: i.id! ,name: i.name!, category: i.category!, entryDate: i.entryDate!, expiryDate: i.expiryDate!, amount: i.amount, unit: i.unit!, remaining: i.remaining))
        }
        return foodArr
    }

    let columns = [
            GridItem(.adaptive(minimum: 80))
        ]
    
    var body: some View {
        ZStack {
            VStack {
                //ghost of codewar again
                // we can sort category by expiryDate and sort the food in each category by expiryDate
                // Using NSOrderedSet, the case of changing element position won't happen, which is better than using Set
                List(NSOrderedSet(array: searchResult.map{$0.category}).map({$0 as! String}), id: \.self) { category in
                    VStack {
                        Text("\(category)")
                            .font(.custom("Helvetica", size: 20))
                            .fontWeight(.semibold)
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(searchResult.filter{$0.category == category}, id: \.self) { food in
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
                    .padding([.top, .bottom])
                    .listRowSeparator(.hidden)
                    .frame(maxWidth: .infinity)
                    .background(
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 0)
                    )
                }
                .listStyle(InsetListStyle())
                .searchable(text: $searchText)
                // Screen Header / title
                .navigationBarTitle("All food")
                .navigationBarBackButtonHidden(true)
                .onAppear{
                    foodArr = filterArr()
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        playSound()
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .font(Font.system(size: 20, weight: .medium))
                    }
                }
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

            VStack {
                Spacer()
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
            }
        }
        .accentColor(Color("PrimaryColor"))
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
