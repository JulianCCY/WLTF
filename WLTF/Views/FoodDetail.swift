//
//  FoodDetail.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI

struct FoodDetail: View {
    
//    @StateObject var globalArr = GlobalArr()
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.expiryDate)]) var allFood: FetchedResults<Food>
    
    let food: FoodStruct
    
    func deleteFood() {
    }
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .strokeBorder(Color.black,lineWidth: 5)
                    .background(Circle().foregroundColor(Color("\(FoodImgFunc.selectColor(food.expiryDate))")))
                    .frame(width: 225, height: 225)
                Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                    .resizable()
                    .frame(width: 160, height: 160)
            }
            .offset(y: 75)
            .padding(.bottom, 100)

            VStack(alignment: .leading) {
                Text("Amount")
                    .font(.title)
                Text("\(Int(food.amount)) \(food.unit)")
                    
                Divider()
                
                Group {
                    Text("Entry date")
                        .font(.title2)
                    Text("\(food.entryDate)")
                        .padding(.bottom)
                }
                
                Group {
                    Text("Expiration date")
                        .font(.title2)
                    HStack {
                        Text("\(formatting(currentDate: food.expiryDate))")
                        Text(calcExpiryText(date: food.expiryDate))
                    }
                    .padding(.bottom)
                }
                Button("Delete food") {
                    DataController().deleteSingleFood(id: food.foodId, context: moc)
                    dismiss()
                }
                Text("\(food.foodId)")
            }
            .padding()
            .navigationBarTitle("\(food.name)")
        Spacer()
        }
    }
}

//struct FoodDetail_Previews: PreviewProvider {
//    static var previews: some View {
////        FoodDetail()
////        FoodDetail(food: globalArr.foodArr[0])
//    }
//}
