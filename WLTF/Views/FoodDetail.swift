//
//  FoodDetail.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI

struct FoodDetail: View {
    
//    let food: FoodStorage
    
//    func deleteFood() {
//
//    }
    
    var body: some View {
        Text("Hello")
//        VStack {
//            ZStack {
//                Circle()
//                    .strokeBorder(Color.black,lineWidth: 5)
//                    .background(Circle().foregroundColor(Color("\(FoodImgFunc.selectColor(food.expireDate))")))
//                    .frame(width: 225, height: 225)
//                Image("\(FoodImgFunc.selectImg(food.name, food.category))")
//                    .resizable()
//                    .frame(width: 180, height: 180)
//            }
//            .offset(y: 75)
//            .padding(.bottom, 100)
//
//            VStack(alignment: .leading) {
//                Text("Amount")
//                    .font(.title)
//                Text("\(food.amount) \(food.unit)")
//
//                Divider()
//
//                Group {
//                    Text("Entry date")
//                        .font(.title2)
//                    Text("\(food.enterDate)")
//                        .padding(.bottom)
//                }
//
//                Group {
//                    Text("Expiration date")
//                        .font(.title2)
//                    Text("\(food.expireDate)")
//                        .padding(.bottom)
//                }
//                Button("Delete food", action: deleteFood)
//            }
//            .padding()
//            .navigationBarTitle("\(food.name)")
//        Spacer()
//        }
    }
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail()
//        FoodDetail(food: foodArr[0])
    }
}
