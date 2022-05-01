//
//  DishAdd.swift
//  WLTF
//
//  Created by iosdev on 25.4.2022.
//

import SwiftUI

struct DishAdd: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State var dishName: String = ""
    @State var ingredient: String = ""
    @State var ingredients: [String] = []
    @State var note: String = ""
    @State var portion: Double = 1
    @State var dishImage: String = "mystery"
    
    @State private var alert = false
    @State private var alertMessage = ""
    
    @State var imageArr:[String] = ["mystery", "dinner", "smallbowl", "bigbowl", "smallplate", "bigplate", "pan", "wok", "vegan", "cookbook", "cookingbook"]

    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            ingredients.remove(atOffsets: offsets)
        }
    }
    
    private func chooseImage(img: String) -> String {
        if img == dishImage {
            return "CheckedItem"
        } else {
            return "Fridge"
        }
    }
    
    var body: some View {
        ZStack {
            
            Color("TertiaryColor")
                .ignoresSafeArea()
            
            VStack {
                List {
                    Section {
                        TextField("Name of your dish", text: $dishName)
                            .font(.system(size: 24))
                        TextField("Notes", text: $note)
                        VStack {
                            Slider(value: $portion, in: 1...20, step: 1)
                            Text("Serving \(Int(portion)) people")
                        }

                    }
                    .listRowBackground(Color("Fridge"))

                    Section {
                        HStack {
                            TextField("Ingredient", text: $ingredient)
                            Button {
                                if (ingredient == "") {
                                    alert = true
                                    alertMessage = "No ingredient"
                                }
                                else {
                                    ingredients.append(ingredient)
                                    ingredient = ""
                                }
                            } label: {
                                Image(systemName: "plus.rectangle")
                                    .font(.system(size: 20))
                            }
                            .buttonStyle(BorderlessButtonStyle())
                            .frame(width: 100, height: 20, alignment: .center)
                            .alert(isPresented: $alert) {
                                Alert(title: Text("Invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Ok")))
                            }
                            .foregroundColor(ingredient == "" ? .gray : Color("PrimaryColor"))
                        }
                        .padding()
                        .listRowBackground(Color("TertiaryColor"))
                        .frame(maxWidth: .infinity, minHeight: 25)
                        .background(
                            Rectangle()
                                .fill(Color("Fridge"))
                                .cornerRadius(10)
                        )
                        
                    }
                    
                    Section {
                        ForEach(ingredients, id: \.self) { i in
                            ZStack {
                                Label {
                                    Text("\(i)")
                                        .padding(.leading)
                                } icon: {
                                    Image(systemName: "fork.knife")
                                        .foregroundColor(Color("PrimaryColor"))
                                }
                                .padding()
                            }
                            .listRowBackground(Color("TertiaryColor"))
                            .listRowSeparator(.hidden)
                            .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                            .background(
                                Rectangle()
                                    .fill(Color("Fridge"))
                                    .cornerRadius(10)
//                                    .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 0)
                            )
                        }
                        .onDelete(perform: deleteItem)
                    }
        
                    
    //                List
                }
                .navigationBarTitle("Create a dish")
                
                HStack {
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack (spacing: 30) {
                            ForEach(imageArr, id: \.self) { i in
                                Button {
                                    dishImage = i
                                } label: {
                                    Image("\(i)")
                                        .resizable()
                                        .frame(width: 80, height: 80)
                                        .background(
                                            Circle()
                                                .fill(Color("\(chooseImage(img: i))"))
                                                .frame(width: 100, height: 100)
                                        )
                                }
                            }
                        }
                        .frame(height: 120)
                        .padding([.leading, .trailing], 10)
                    }
                    Spacer()
                }
                .background(Color("TertiaryColor"))
                .padding([.leading, .top, .trailing])
                
                Button {
                    if dishName.isEmpty == true {
                        alert = true
                        alertMessage = "Please name your dish"
                        
                    } else {
                        DataController().addDish(dishName: dishName,
                                                 portion: Int(portion),
                                                 note: note,
                                                 ingredients: ingredients,
                                                 img: dishImage,
                                                 context: managedObjectContext
                        )
                        dismiss()
                    }
                    
                } label: {
                    //button one
                    Label("Confirm", systemImage: "checkmark")
                }
                .disabled(dishName.isEmpty)
                .alert(isPresented: $alert) {
                    Alert(title: Text("Invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("Ok")))
                }
            
                
            } // vstack
        } // big z

    }
}

struct DishAdd_Previews: PreviewProvider {
    static var previews: some View {
        DishAdd()
    }
}
