//
//  ShoppingList.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//

import SwiftUI

struct ShoppingList: View {
    
    // Use Core Data in this file
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss

//    @FetchRequest(sortDescriptors: [SortDescriptor()]) var allItems: FetchedResults<Shop>
    
    var body: some View {
        VStack {
            List {
//                ForEach(allItems, id: \.self) { item in
//                        VStack(alignment: .leading, spacing: 6) {
//                            Text(item.name)
//                            Text(item.amount)
//                            Text(item.entryDate)
//                        Spacer()
//                        Text(calcExpiry(date: item.expireDate))
//                            .foregroundColor(.brown)
//                }
            }
            .listStyle(GroupedListStyle())
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
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingList()
    }
}
