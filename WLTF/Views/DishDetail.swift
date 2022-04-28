//
//  DishDetail.swift
//  WLTF
//
//  Created by iosdev on 26.4.2022.
//

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
        
            VStack {
                Text("\(dish.dishName)")
                    .font(.largeTitle)
                    .bold()
                ZStack {
                    Circle()
                        .strokeBorder(Color.black,lineWidth: 5)
                        .background(Circle().foregroundColor(Color("BackgroundColor")))
                        .frame(width: 190, height: 190)
                    Image("\(dish.dishImg)")
                        .resizable()
                        .frame(width: 140, height: 140)
                }
    //            .offset(y: 50)
                .padding(.bottom, 40)
                
                HStack {
                    Text("Portion: ")
                        .fontWeight(.medium)
//                        .font(.title)
//                        .padding(.leading, 20)
                    Text ("\(Int(dish.portion)) people")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 35)
                
                VStack(alignment: .leading) {
//                    if dish.note != "" {
//                        HStack {
//                            Text("Notes: ")
//                                .fontWeight(.medium)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.leading, 35)
//
//                        Text("\(dish.note)")
//                    }
                    HStack {
                        Text("Notes: ")
                            .fontWeight(.medium)
                        if dish.note == "" {
                            Text("Blank")
                                .font(.subheadline)
                                .foregroundColor(.black)
                        } else {
                            VStack {
                                Text(dish.note)
                            }
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 35)
                }

                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title)
                        .padding(.leading, 20)
                    
                    List(dish.ingredientArr, id: \.self) { i in
                        
                        ZStack {
                            if check(name: i) {
                                if DataController().checkRemainingFromDish(name: i) {
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
                                        Text("\(i) (a little bit left)")
                                            .foregroundColor(.yellow)
                                            .frame(height: 20)
                                            .font(.headline)
                                    } icon: {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.yellow)
                                    }
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
                        
                    }
                    .listStyle(InsetListStyle())
                        
                    
                    
                    Spacer()
                    // Delete/Remove this food
                    HStack {
                        Spacer()
                        Button() {
                            alert = true
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .padding()
                        .foregroundColor(Color(red: 0.9686, green: 0.2039, blue: 0.1922).opacity(0.65))
//                        .background(Color(red: 0.7569, green: 0.898, blue: 1).opacity(0.61))
                        .background(Color(red: 0.9569, green: 0.4941, blue: 0.4863).opacity(0.50))
                        .cornerRadius(20)
                        .confirmationDialog("", isPresented: $alert) {
                            Button("Confirm", role:  .destructive) {
                                DataController().deleteDish(dishId: dish.dishId, context: moc)
                                dismiss()
                            }
                        }
                        Spacer()
                    }
                }
                .padding()
                .navigationBarTitle("")
                
            Spacer()
        }
    }
}

//struct DishDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        DishDetail()
//    }
//}
