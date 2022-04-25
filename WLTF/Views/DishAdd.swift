//
//  DishAdd.swift
//  WLTF
//
//  Created by iosdev on 25.4.2022.
//

import SwiftUI

struct DishAdd: View {
    
    @State var dishName: String = ""
    @State var ingredient: String = ""
    @State var ingredients: [String] = []
    @State var note: String = ""
    @State var portion: Int = 1
    @State var dishImage: String = "meal"
    
    @State var sliderValue: Double = 1.0
    
    @State var imageArr:[String] = ["meal", "mystery", "dinner", "smallbowl", "bigbowl", "smallplate", "bigplate", "pan", "wok", "vegan", "cookbook", "cookingbook"]

    private func deleteItem(offsets: IndexSet) {
        withAnimation {
            ingredients.remove(atOffsets: offsets)
        }
    }
    
    private func chooseImage(img: String) -> String {
        if img == dishImage {
            return "CheckedItem"
        } else {
            return "BackgroundColor"
        }
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    TextField("Name of your dish", text: $dishName)
                        .font(.system(size: 26))
//                    ZStack {
//                        RoundedRectangle(cornerRadius: 10)
//                            .strokeBorder(Color.black,lineWidth: 2)
//                            .background(Color.clear)
//                            .frame(width: 280, height: 100)
                        TextField("Notes", text: $note)
//                            .multilineTextAlignment(.leading)
//                            .frame(width: 270, height: 90)
//                    }
                    VStack {
                        Slider(value: $sliderValue, in: 1...20, step: 1)
                        Text("Serving \(Int(sliderValue)) people")
                    }

                }
//                .background(
//                    RoundedRectangle(cornerRadius: 5)
//                        .fill(Color.clear)
//                        .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 0)
//                )
//                .frame(alignment: .center)
                
                Section {
                    HStack {
                        TextField("Ingredient", text: $ingredient)
                        Button {
                            ingredients.append(ingredient)
                            ingredient = ""
                        } label: {
                            Image(systemName: "plus.rectangle")
                                .font(.system(size: 20))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                        .frame(width: 100, height: 20, alignment: .center)
                    }
                    .frame(maxWidth: .infinity, minHeight: 25)
                    
                }
//                .frame(height: 30)

//                Divider()
                
                Section {
                    ForEach(ingredients, id: \.self) { i in
                        ZStack {
                            Label {
                                Text("\(i)")
                            } icon: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color("SecondaryColor"))
                            }

                        }
                        .listRowSeparator(.hidden)
                        .frame(maxWidth: .infinity, minHeight: 60, alignment: .leading)
                        .background(
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.5), radius: 2, x: 0, y: 0)
                        )
                    }
                    .onDelete(perform: deleteItem)
                }
    
                
//                List
            }
            .navigationBarTitle("Create a dish")
//            .navigationBarHidden(true)
            
            HStack {
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack (spacing: 20) {
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
    //                                        .fill(Color("BackgroundColor"))
                                    )
                            }
                        }
                    }
                    .frame(height: 120)
                }
                Spacer()
            }
            .padding([.leading, .top, .trailing])
        
            
        }
    }
}

struct DishAdd_Previews: PreviewProvider {
    static var previews: some View {
        DishAdd()
    }
}
