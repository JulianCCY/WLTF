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
    
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.expiryDate)]) var allFood: FetchedResults<Food>
    
    let food: FoodStruct
    
    @State private var alert = false
    @State private var alertMessage = ""
    
    var body: some View {
        VStack {
            Text("\(food.name)")
                .font(.largeTitle)
                .bold()
            ZStack {
                Circle()
                    .strokeBorder(Color.black,lineWidth: 5)
                    .background(Circle().foregroundColor(Color("\(FoodImgFunc.selectColor(food.expiryDate))")))
                    .frame(width: 190, height: 190)
                Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                    .resizable()
                    .frame(width: 140, height: 140)
            }
//            .offset(y: 50)
            .padding(.bottom, 40)

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
                
                Spacer()
                // Delete/Remove this food
                HStack() {
                    Spacer()
                    if checkExpired(expiryDate: food.expiryDate) == false{
                        Button() {
                            alert = true
                        } label: {
                            
                            Label("Consumed", systemImage: "fork.knife")
                        }
                        .padding()
                        .foregroundColor(Color(red: 0.1059, green: 0.251, blue: 0.5098).opacity(0.61))
                        .background(Color(red: 0.7569, green: 0.898, blue: 1).opacity(0.61))
                        .cornerRadius(20)
                        .confirmationDialog("Enjoy your food", isPresented: $alert, titleVisibility: .visible) {
                            Button("Bon appétit!", role: .destructive) {
                                DataController().deleteSingleFood(id: food.foodId, context: moc)
                                dismiss()
                            }
                            Button("Cancel", role: .cancel) { }
                        }
                    } else {
                        Button() {
                            alert = true
                        } label: {
                            
                            Label("Remove", systemImage: "trash")
                        }
                        .padding()
                        .foregroundColor(Color(red: 0.0902, green: 0.0549, blue: 0.3294).opacity(0.61))
                        .background(Color(red: 0.8706, green: 0.8392, blue: 0.9529).opacity(0.61))
                        .cornerRadius(20)
                        .confirmationDialog("Please don't waste food next time...", isPresented: $alert, titleVisibility: .visible) {
                            Button("Remove", role: .destructive) {
                                DataController().deleteSingleFood(id: food.foodId, context: moc)
                                dismiss()
                            }
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

//struct FoodDetail_Previews: PreviewProvider {
//    static var previews: some View {
////        FoodDetail()
////        FoodDetail(food: globalArr.foodArr[0])
//    }
//}
