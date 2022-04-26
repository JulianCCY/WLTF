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

                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(.title)
                    
                    List(dish.ingredientArr, id: \.self) { i in
                        
                        Text("\(i)")
                        
                    }
                        
                    
                    
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
                        .foregroundColor(Color(red: 0.1059, green: 0.251, blue: 0.5098).opacity(0.61))
                        .background(Color(red: 0.7569, green: 0.898, blue: 1).opacity(0.61))
                        .cornerRadius(20)
                        .confirmationDialog("", isPresented: $alert) {
                            Button("Confirm") {
//                                DataController().deleteSingleFood(id: food.foodId, context: moc)
//                                dismiss()
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
