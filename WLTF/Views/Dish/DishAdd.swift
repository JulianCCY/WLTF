//
//  DishAdd.swift
//  WLTF
//
//  Created by iosdev on 25.4.2022.
//
// This is the DishAdd screen, user can create their own dish here
// Navigated from DishMain

import SwiftUI

struct DishAdd: View {
    
//    coredata
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
    
//    for selecting images
    @State var imageArr:[String] = ["mystery", "dinner", "smallbowl", "bigbowl", "smallplate", "bigplate", "pan", "wok", "vegan", "cookbook", "cookingbook"]
    
    private func chooseImage(img: String) -> String {
        if img == dishImage {
            return "CheckedItem"
        } else {
            return "Fridge"
        }
    }
    
//    on delete ingredient
    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            ingredients.remove(atOffsets: offsets)
        }
    }
    
//    environment locale cannot localize picker text, that's why we need a funcition
    private func translate(input: String) -> String {
        if input == "fi" {
            return "Luoda ruokalaji"
        }
        else {
            return "Create a dish"
        }
    }
    
    var body: some View {
        ZStack {
            
            Color("TertiaryColor")
                .ignoresSafeArea()
            
            VStack {
                List {
                    Section {
                        TextField("dish_name", text: $dishName)
                            .font(.system(size: 24))
                        TextField("notes", text: $note)
                        VStack {
                            Slider(value: $portion, in: 1...20, step: 1)
                            Text("serving \(Int(portion)) people")
                        }

                    }
                    .listRowBackground(Color("Fridge"))

                    Section {
                        HStack {
                            TextField("ingredient", text: $ingredient)
                            Button {
                                if (ingredient == "") {
                                    alert = true
                                    alertMessage = "no_ingredient"
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
                                Alert(title: Text("invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("ok")))
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
                            )
                        }
                        .onDelete(perform: deleteItem)
                    }
        
                    
    //                List
                }
                .navigationBarTitle("\(translate(input: UserDefaults.standard.string(forKey: "lang") ?? "en"))")
                
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
                    Label("confirm", systemImage: "checkmark")
                }
                .disabled(dishName.isEmpty)
                .alert(isPresented: $alert) {
                    Alert(title: Text("invalid"), message: Text("\(alertMessage)"), dismissButton: .default(Text("ok")))
                }
            
                
            } // vstack
        } // big z
        .environment(\.locale, .init(identifier: UserDefaults.standard.string(forKey: "lang") ?? "en"))
    }
}

struct DishAdd_Previews: PreviewProvider {
    static var previews: some View {
        DishAdd()
    }
}
