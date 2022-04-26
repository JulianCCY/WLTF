//
//  DishMain.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//

import SwiftUI

struct DishMain: View {
    
    @State private var dishArr: [DishStruct] = []
    
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
//                ScrollView(.horizontal, showsIndicators: false) {
//                    HStack(spacing: 10) {
//
//                        ForEach(dishArr, id: \.self) { i in
//
//                           GeometryReader { geometry in
//                               DishCard(title: i)
//                                   .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / -15), axis: (x: 0, y: 10, z: 0))
//                           }
//                           .frame(width: 250, height: 250)
//                       }
//                   }
////                   .padding([.leading, .trailing], 30)
//                   .padding(.leading, 70)
//                   .padding(.trailing, 70)
//                }
                
//                Ingredients
                VStack(alignment: .leading) {
                    HStack() {
                        Circle()
                            .fill(Color("CheckedItem"))
                            .frame(width: 25, height: 25)
                        Text("Sufficient ingredient")
                    }
                    HStack() {
                        Circle()
                            .fill(Color("1dayItem"))
                            .frame(width: 25, height: 25)
                        Text("Insufficient ingredient")
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
