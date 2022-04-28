//
//  FoodDetail.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI
import SimpleToast


struct FoodDetail: View {
    
//    @StateObject var globalArr = GlobalArr()
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.expiryDate)]) var allFood: FetchedResults<Food>
    
    let food: FoodStruct
    
    @State private var remaining: Double = 0
    private let max: Double = 100
    
    @State private var alert = false
    @State private var alertMessage = ""
    @State private var showToast = false
    
    @State private var toastOptions = SimpleToastOptions(
        alignment: .top,
        hideAfter: 1,
        backdrop: Color.black.opacity(0.2),
        animation: .default,
        modifierType: .fade
    )
    
    var body: some View {
        VStack {
            Text("\(food.name)")
                .font(.largeTitle)
                .bold()
            ZStack {
//                Circle()
//                    .strokeBorder(Color.black,lineWidth: 5)
//                    .background(Circle().foregroundColor(Color("\(FoodImgFunc.selectColor(food.expiryDate))")))
//                    .frame(width: 190, height: 190)
//                $remaining.wrappedValue
                if remaining >= 70 {
                    RemainingCircle(value: remaining,
                                    maxValue: self.max,
                                    style: .line,
                                    foregroundColor: Color("Green"),
                                    lineWidth: 8)
                                .frame(height: 190)
                    Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                        .resizable()
                        .frame(width: 140, height: 140)
                } else if remaining >= 30 {
                    RemainingCircle(value: remaining,
                                    maxValue: self.max,
                                    style: .line,
                                    foregroundColor: .yellow,
                                    lineWidth: 8)
                                .frame(height: 190)
                    Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                        .resizable()
                        .frame(width: 140, height: 140)
                } else {
                    RemainingCircle(value: remaining,
                                    maxValue: self.max,
                                    style: .line,
                                    foregroundColor: .red,
                                    lineWidth: 8)
                                .frame(height: 190)
                    Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                        .resizable()
                        .frame(width: 140, height: 140)
                }
                
            }
//            .offset(y: 50)
            .padding(.bottom, 20)
            
            VStack {
                Slider(value: $remaining, in: 0...100, step: 1)
                    .disabled(checkExpired(expiryDate: food.expiryDate) == true)
                //when the food is expired, slider will not be working
                    .accentColor(Color("SecondaryColor"))
                Text("\(Int(remaining)) % remaining")
                    .foregroundColor(Color(.systemGray))
            }
            .padding([.leading, .trailing], 50)

            VStack(alignment: .leading) {
                Text("Amount")
                    .font(.title)
                Text("\(Int(food.amount)) \(food.unit)")
                    
                Divider()
                
                Group {
                    Text("Entry date")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.bottom, 1)
                    Text("\(food.entryDate)")
                        .padding(.bottom)
                }
                
                Group {
                    Text("Expiration date")
                        .font(.title2)
                        .fontWeight(.medium)
                        .padding(.bottom, 1)
                    VStack(alignment: .leading){
                        Text("\(formatting(currentDate: food.expiryDate))")
                        Text(calcExpiryText(date: food.expiryDate))
//                            .padding(.bottom, 1)
                    }
                    .padding(.bottom)
                    
                }
                
                Spacer()
                // Delete/Remove this food
                HStack {
                    Spacer()
                    if checkExpired(expiryDate: food.expiryDate) == false && remaining > 0.0{
                        Button() {
                            alert = true
                        } label: {
                            
                            Label("Consumed", systemImage: "fork.knife")
                        }
                        .padding()
                        .foregroundColor(Color(red: 0.1059, green: 0.251, blue: 0.5098).opacity(0.61))
                        .background(Color(red: 0.7569, green: 0.898, blue: 1).opacity(0.61))
                        .cornerRadius(20)
                        .confirmationDialog("Enjoy your food", isPresented: $alert) {
                            Button("Bon appétit!") {
                                DataController().consumeFood(id: food.foodId, remaining: remaining)
//                                DataController().deleteSingleFood(id: food.foodId, context: moc)
//                                dismiss()
                            }
                        }
                    } else if remaining == 0 && checkExpired(expiryDate: food.expiryDate) == false || checkExpired(expiryDate: food.expiryDate) == true {
                        Button() {
                            alert = true
                        }
                        label: {
                            
                            Label("Remove", systemImage: "trash")
                        }
                        .padding()
                        .foregroundColor(Color(red: 0.0902, green: 0.0549, blue: 0.3294).opacity(0.61))
                        .background(Color(red: 0.8706, green: 0.8392, blue: 0.9529).opacity(0.61))
                        .cornerRadius(20)
                        .confirmationDialog("", isPresented: $alert) {
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
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing) {
                    // Top Right delete button
                    Button {
                        showToast.toggle()
                        DataController().fromDetailsAddToBuy(name: food.name, context: moc)
                    } label: {
                        Label("Add to cart", systemImage: "cart.badge.plus")
                    }
                }
            }
        Spacer()
        }
        .onAppear{remaining = food.remaining}
        .simpleToast(isPresented: $showToast, options: toastOptions, onDismiss: {}) {
            HStack{
               Image(systemName: "checkmark")
               Text("Added to list").bold()
           }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
            .background(Color("BackgroundColor"))
            .foregroundColor(.black)
            .cornerRadius(5)
            .offset(y: -92)
//            .edgesIgnoringSafeArea(.top)
        }

    }
}

//struct FoodDetail_Previews: PreviewProvider {
//    static var previews: some View {
////        FoodDetail()
////        FoodDetail(food: globalArr.foodArr[0])
//    }
//}
