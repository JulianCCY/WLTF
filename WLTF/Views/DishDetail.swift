//
//  DishDetail.swift
//  WLTF
//
//  Created by iosdev on 26.4.2022.
//
// This is DishDetail screen, displaying individual dish details
// Navigated from DishMain

import SwiftUI

struct DishDetail: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    let dish: DishStruct
    
    @State private var alert = false
    @State private var alertMessage = ""
    
    private func check(name: String) -> Bool {
        return DataController().checkIfExist(foodName: name) ? true : false
    }
    
    var body: some View {
        
        ZStack {
            
            Color("TertiaryColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                
                HStack {
                    ZStack {
                        Circle()
                            .strokeBorder(Color.black,lineWidth: 5)
                            .background(Circle().foregroundColor(Color("Fridge")))
                            .frame(width: 150, height: 150)
                        Image("\(dish.dishImg)")
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                    .padding(.leading, 20)
                    .padding(.trailing, 5)
                    
                    VStack(alignment: .leading) {
                        Text("\(dish.dishName)")
                            .font(.largeTitle)
                            .bold()
                        HStack {
                            Text("portion:")
                                .fontWeight(.medium)
                            Text ("\(Int(dish.portion)) people")
                        }
                    }
                    
                } // image and name hstack
                
                    
                    VStack(alignment: .leading) {
                        if dish.note != "" {
                            HStack {
                                VStack {
                                    Text("notes: ")
                                        .fontWeight(.medium)
                                    Spacer()
                                }
                                ScrollView {
                                    VStack {
                                        Text("\(dish.note)")
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 60, alignment: .leading)
                            .padding([.leading, .trailing], 35)
                            .padding(.vertical)

                        }
                    }
                
//                ingredients list
                    VStack(alignment: .leading) {
                        Text("ingredients")
                            .font(.title)
                            .padding(.leading, 20)
                        
                        List(dish.ingredientArr, id: \.self) { i in
                            
                            ZStack {
                                if check(name: i) {
                                    Label {
                                        Text("\(i)")
                                            .foregroundColor(Color("Green"))
                                            .frame(height: 20)
                                            .font(.headline)
                                    } icon: {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(Color("Green"))
                                    }
                                                                        
                                } else {
                                    Label {
                                        Text("\(i)")
                                            .frame(height: 20)
                                            .font(.headline)
                                            .listRowSeparator(.hidden)
                                            .foregroundColor(Color("Red"))
                                    } icon: {
                                        Image(systemName: "xmark")
                                            .foregroundColor(Color("Red"))
                                    }
                                }
                            }
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color("TertiaryColor"))
                            
                        }
                        .listStyle(InsetListStyle())
                            
                    }//Vstack
//                }//scrollview
                .padding()
                .navigationBarTitle("")
                
                // Delete button
                HStack {
                    Spacer()
                    Button() {
                        alert = true
                    } label: {
                        Label("delete", systemImage: "trash")
                    }
                    .padding()
                    .foregroundColor(Color(red: 0.9686, green: 0.2039, blue: 0.1922).opacity(0.65))
                    .background(Color(red: 0.9569, green: 0.4941, blue: 0.4863).opacity(0.50))
                    .cornerRadius(20)
                    .confirmationDialog("", isPresented: $alert) {
                        Button("confirm", role:  .destructive) {
                            DataController().deleteDish(dishId: dish.dishId, context: moc)
                            dismiss()
                        }
                    }
                    Spacer()
                }
            Spacer()
        } // main v
        } // big z
        .environment(\.locale, .init(identifier: UserDefaults.standard.string(forKey: "lang") ?? "en"))
    }
}
