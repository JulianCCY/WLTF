//
//  AddToBuyScreen.swift
//  WLTF
//
//  Created by Chan Chung Yin on 19/4/2022.
//

import SwiftUI
import CoreData

struct AddToBuyScreen: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var foodName = ""
    @State private var description = ""
    
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("Food name:", text: $foodName)
                    TextField("Description (Option):", text: $description)
                }
                HStack {
                    Spacer()
                    Button("Add"){
                        DataController().addToBuy(name: foodName, descr: description, context: moc)
                    }
                    Spacer()
                }
            }
        }
        
    }
}

struct AddToBuyScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddToBuyScreen()
    }
}
