//
//  FoodDetail.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//
// This is the food detail screen which shows the user about their food
// Showing name, category, amount, date of entry, and date of expiry
// User can also delete the selected food here
// User can also add selected food to shopping list in case they want some to remind themselves to buy

import SwiftUI
import SimpleToast


struct FoodDetail: View {
    
//    coredata
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    let food: FoodStruct
    
//    for the remaining circle around the food image
    @State private var remaining: Double = 0
    private let max: Double = 100
    
//    alert and toast
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
        ZStack {
            
            Color("TertiaryColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    // food image wrapped with remaining circle status bar
                    ZStack {
                        if remaining >= 70 {
                            RemainingCircle(value: remaining,
                                            maxValue: self.max,
                                            style: .line,
                                            foregroundColor: Color("Green"),
                                            lineWidth: 8)
                                        .frame(height: 150)
                            Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                                .resizable()
                                .frame(width: 100, height: 100)
                        } else if remaining >= 30 {
                            RemainingCircle(value: remaining,
                                            maxValue: self.max,
                                            style: .line,
                                            foregroundColor: .yellow,
                                            lineWidth: 8)
                                        .frame(height: 150)
                            Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                                .resizable()
                                .frame(width: 100, height: 100)
                        } else {
                            RemainingCircle(value: remaining,
                                            maxValue: self.max,
                                            style: .line,
                                            foregroundColor: .red,
                                            lineWidth: 8)
                                        .frame(height: 150)
                            Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    } //food image zstack
                    
                    
                    //food name and amount
                    VStack(alignment: .leading) {
                        Text("\(food.name)")
                            .font(.largeTitle)
                            .bold()
                            .padding(.bottom, 1)
                        Text("Amount")
                        .font(.title2)
                            .fontWeight(.medium)
                        Text("\(Int(food.amount)) \(food.unit)")
                    }// foodname vstack
                    .padding(.trailing, 50)
                } // hstack
                
//                slider
                VStack {
                    Slider(value: $remaining, in: 0...100, step: 1)
                        .disabled(checkExpired(expiryDate: food.expiryDate) == true)
                    //when the food is expired, slider will not be working
                        .accentColor(Color("BackgroundColor"))
                    Text("\(Int(remaining)) % remaining")
                        .foregroundColor(Color(.systemGray))
                }
                .padding([.leading, .trailing], 40)
                .padding([.top, .bottom], 50)
                
//                dates display
                VStack(alignment: .leading) {
                    Group {
                        Text("Entry date")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.bottom, 0.2)
                        Text("\(food.entryDate)")
                            .padding(.bottom)
                    }

                    Group {
                        Text("Expiration date")
                            .font(.title2)
                            .fontWeight(.medium)
                            .padding(.bottom, 0.2)
                        VStack(alignment: .leading){
                            Text("\(formatting(currentDate: food.expiryDate))")
                            Text(calcExpiryText(date: food.expiryDate))
                        }
                        .padding(.bottom)
                    }
                }// date vstack
                .padding([.leading, .trailing], 50)
                
//                Spacer()
//                // Delete/Remove this food
//                HStack {
//                    Spacer()
//                    if checkExpired(expiryDate: food.expiryDate) == false && remaining != 0.0{
//                        Button() {
//                            alert = true
//                        } label: {
//
//                            Label("Consumed", systemImage: "fork.knife")
//                        }
//                        .padding()
//                        .foregroundColor(Color(red: 0.1059, green: 0.251, blue: 0.5098).opacity(0.61))
//                        .background(Color(red: 0.7569, green: 0.898, blue: 1).opacity(0.61))
//                        .cornerRadius(20)
//                        .confirmationDialog("Enjoy your food", isPresented: $alert) {
//                            Button("Bon appétit!") {
//                                DispatchQueue.main.async {
//                                    DataController().consumeFood(id: food.foodId, remaining: remaining, context: moc)
//                                }
//                            }
//                        }
//                    } else if remaining == 0 && checkExpired(expiryDate: food.expiryDate) == false || checkExpired(expiryDate: food.expiryDate) == true {
//                        Button() {
//                            alert = true
//                        }
//                        label: {
//
//                            Label("Remove", systemImage: "trash")
//                        }
//                        .padding()
//                        .foregroundColor(Color(red: 0.0902, green: 0.0549, blue: 0.3294).opacity(0.61))
//                        .background(Color(red: 0.8706, green: 0.8392, blue: 0.9529).opacity(0.61))
//                        .cornerRadius(20)
//                        .confirmationDialog("", isPresented: $alert) {
//                            Button("Remove", role: .destructive) {
//                                DataController().deleteSingleFood(id: food.foodId, context: moc)
//                                dismiss()
//                            }
//                        }
//                    }
//                    Spacer()
                Spacer()
                
//                consume food button
                HStack {
                    Spacer()
                    if checkExpired(expiryDate: food.expiryDate) == false && remaining > 0{
                        Button() {
                            alert = true
                        } label: {

                            Label("Consumed", systemImage: "fork.knife")
                        }
                        .padding()
                        .foregroundColor(Color(red: 0.1059, green: 0.251, blue: 0.5098).opacity(0.61))
                        .background(Color(red: 0.7569, green: 0.898, blue: 1).opacity(0.61))
                        .cornerRadius(20)
                        .confirmationDialog("Are you sure", isPresented: $alert){
                            Button("consume", role: .destructive){
                                DataController().consumeFood(id: food.foodId, remaining: remaining, context: moc)
                            }
                        }
                        
                    } else if remaining == 0 || checkExpired(expiryDate: food.expiryDate) == true {
                        Button() {
//                            alert = true
                            DataController().deleteSingleFood(id: food.foodId, context: moc)
                            dismiss()
                        }
                        label: {
                            Label("Remove", systemImage: "trash")
                        }
                        .padding()
                        .foregroundColor(Color(red: 0.0902, green: 0.0549, blue: 0.3294).opacity(0.61))
                        .background(Color(red: 0.8706, green: 0.8392, blue: 0.9529).opacity(0.61))
                        .cornerRadius(20)
                    }
                    Spacer()
                }// button hstack
                .padding(.bottom, 20)
                
            }// main vstack
        } // big zstack
        .accentColor(Color("PrimaryColor"))
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
        }

    }
}

