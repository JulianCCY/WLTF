//
//  DishMain.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//

import SwiftUI

struct DishMain: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var dishArr: [DishStruct] = []
    
    @State private var alert = false
    @State private var alertMessage = ""
    
    private func filterArr() -> [DishStruct] {
        dishArr = []
        dishArr = DataController().fetchAllDishes().map{DishStruct(dishId: $0.id!, dishName: $0.dishName!, dishImg: $0.dishImg!, portion: Int($0.portion), note: $0.note!, ingredientArr: DataController().fetchRelatedIngredient(dishId: $0.id!).map{$0.name!})}
        return dishArr
    }
    
    var body: some View {
        
        ZStack {
            VStack {
                VStack {
                    HStack {
                        Text("Menu")
                            .font(.system(size: 36))
                            .fontWeight(.bold)
                            .padding(.top, 50)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    Spacer()
                }
                
// Horizontal scroll
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {

                        ForEach(dishArr, id: \.self) { i in

                           GeometryReader { geometry in
                               NavigationLink {
                                   DishDetail(dish: i)
                               }
                               label: {
                                   DishCard(title: i.dishName, image: i.dishImg, ingredients: i.ingredientArr)
                               }
//                                   .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -15), axis: (x: 0, y: 10, z: 0))
                           }
                           .frame(width: 250, height: 280)
                       }
                   }
//                   .padding([.leading, .trailing], 70)
                    .padding(.leading, 80)
                    .padding(.trailing, 50)
                   .padding(.top, 50)
                }
                
//                Ingredients
                VStack(alignment: .leading) {
                    HStack() {
                        Circle()
                            .fill(Color("Green"))
                            .frame(width: 16, height: 16)
                        Text("Ample ingredient")
                            .font(.system(size: 14))
                    }
                    HStack() {
                        Circle()
                            .fill(Color("Red"))
                            .frame(width: 16, height: 16)
                        Text("Inadequate ingredient")
                            .font(.system(size: 14))
                    }
                }
                .padding(.top, 30)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: DishAdd()) {
                            // Navigate to add food screen
                            Image(systemName: "plus.square.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color("PrimaryColor"))
                                .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
//                                .padding(.trailing)
                        }
                    }
                }
                .padding([.trailing, .bottom])

            }
            
            VStack {
                HStack {
                    Spacer()
                    Button {
                        alert = true
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 22))
                            .padding(EdgeInsets(top: 12, leading: 0, bottom: 0, trailing: 15))
                    }
                    .alert("Delete all of your dishes", isPresented: $alert) {
                        Button("Confirm", role: .destructive) {
                            DataController().deleteAllDishes()
                            moc.refreshAllObjects()
                            dishArr = []
                        }
                        Button("Cancel", role: .cancel) { }
                    }
                    .disabled(dishArr.isEmpty)
                }
                Spacer()
            }
            
        }
        .onAppear{dishArr = filterArr()}
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct DishMain_Previews: PreviewProvider {
    static var previews: some View {
        DishMain()
    }
}
