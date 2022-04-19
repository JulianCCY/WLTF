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
    @FetchRequest(sortDescriptors: [SortDescriptor(\.id)]) var toBuyItems: FetchedResults<Shopping>
    
    var body: some View {
        NavigationView {
            VStack() {
                NavigationLink(destination: AddToBuyScreen()) {
                    Label("Edit", systemImage: "plus")
                }
                List{
                    ForEach(toBuyItems) { food in
                        VStack(alignment: .leading, spacing: 5) {
                            Text(food.name!)
                                .bold()
                            Text(food.details!)
                        }
                    }.onDelete(perform: removeListItem)
                }
                .navigationTitle("Grocery List")
                
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
                        
                    } label: {
                        Label("", systemImage: "trash")
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        
        
        
    }
//        VStack {
//
//            Text("Shopping List")
//            List {
//                Text("Hi")
//            }
//
    
    
//        }
//        .navigationTitle("")
//        .navigationBarHidden(true)
    
    private func removeListItem(offsets: IndexSet) {
        withAnimation{
            offsets.map {toBuyItems[$0]}.forEach(moc.delete)
            DataController().save(context: moc)
        }
    }
}

struct ShoppingList_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingList()
    }
}
