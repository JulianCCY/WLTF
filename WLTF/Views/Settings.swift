//
//  Settings.swift
//  WLTF
//
//  Created by iosdev on 24.4.2022.
//

import SwiftUI

enum languages {
    case english, suomi
}

struct Settings: View {
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var fridgeName: String = ""
    @State private var chosenLanguage: languages = languages.english
    @State private var guidelines: [String] = ["General", "Home", "Adding items", "Grocery list", "Dishes"]
    
    var language: String {
        switch chosenLanguage {
          case .english:
              return "English 🇬🇧"
          case .suomi:
              return "Suomi 🇫🇮"
        }
    }
    
    var body: some View {
        
        ZStack {
            VStack {
//                Naming
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Name your fridge here!")
                            .font(.headline)
                        TextField("Type here...", text: $fridgeName)
                    }
//                    .frame(width: 200)
                    .padding()
                    
                    Spacer()
                }
                
                Picker("Select language", selection: $chosenLanguage) {
                    Text("English 🇬🇧")
                        .tag(languages.english)
                    Text("Suomi 🇫🇮")
                        .tag(languages.suomi)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
    //            guidelines
                ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 20) {
                       
    //                   general
                       ZStack {
                           VStack(alignment: .leading) {
                               Text("General in WLTF")
                                   .font(.title2)
                                   .fontWeight(.semibold)
                               Spacer()
                               
                               HStack {
                                   RoundedRectangle(cornerRadius: 10)
                                       .fill(Color("NormalItem"))
                                       .frame(width: 50, height: 50)
                                       .rotationEffect(.degrees(-3))
                                   Text("Normal items will be shown with this blue color.")
                                       .font(.subheadline)
                               }
                               HStack {
                                   Spacer()
                                   Text("Color of items that will be expired in 3 days.")
                                       .font(.subheadline)
                                   RoundedRectangle(cornerRadius: 10)
                                       .fill(Color("3daysItem"))
                                       .frame(width: 50, height: 50)
                                       .rotationEffect(.degrees(6))
                               }
                               HStack {
                                   RoundedRectangle(cornerRadius: 10)
                                       .fill(Color("1dayItem"))
                                       .frame(width: 50, height: 50)
                                       .rotationEffect(.degrees(5))
                                   Text("Color of items that will be expired within 1 day.")
                                       .font(.subheadline)
                               }
                               HStack {
                                   Text("Color of items that are expired.")
                                       .font(.subheadline)
                                   RoundedRectangle(cornerRadius: 10)
                                       .fill(Color("ExpiredItem"))
                                       .frame(width: 50, height: 50)
                                       .rotationEffect(.degrees(-4))
                               }
                               HStack {
                                   Image(systemName: "plus.rectangle")
                                       .font(.system(size: 20))
                                       .foregroundColor(.blue)
                                   Text("Button for adding item to list.")
                                       .font(.subheadline)
                               }
                               .padding(.bottom)
                               HStack{
                                   Text("Gray colored")
                                       .foregroundColor(.gray)
                                       .font(.subheadline)
                                   Text(" =  input fields.")
                                       .font(.subheadline)
                               }
                           }
                           .padding()
                       }
                       .cornerRadius(10)
                       .frame(width: 325, height: 400)
                       .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color("BackgroundColor"))
                       )
                       .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 1, y: 1)
                       
                       
//                   home
                  ZStack {
                      VStack(alignment: .leading) {
                          Text("Home page")
                              .font(.title2)
                              .fontWeight(.semibold)
                          
                          Text("When fridge is closed")
                              .font(.title3)
                              .fontWeight(.medium)
                              .padding(.top, 10)
                          
                          HStack {
                              ZStack {
                                  Image("Purple note")
                                      .resizable()
                                      .frame(width: 50, height: 50)
                                      .overlay(
                                        Image("Red note")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .overlay(
                                              Image("Orange note")
                                                  .resizable()
                                                  .frame(width: 50, height: 50)
                                                  .overlay(
                                                      Text("3")
                                                          .foregroundColor(Color.black)
                                                          .font(.subheadline)
                                                  )
                                                  .rotationEffect(.degrees(3))
                                                  .offset(x: -5)
                                            )
                                            .rotationEffect(.degrees(3))
                                            .offset(x: -5)
                                      )
                                      .rotationEffect(.degrees(3))
                              }
                              Text("Number of items that are expiring according to color.")
                                  .font(.subheadline)
                          }
                          HStack {
                              Spacer()
                              Text("Tab on fridge door to open your fridge.")
                                  .font(.subheadline)
//                                  .frame(width: 280)
                              Spacer()
                              Image(systemName: "hand.point.left")
                                  .font(.system(size: 20))
                                  .frame(alignment: .trailing)
                          }
                          .padding(.top, 5)
                          
                          Spacer()
                          
                          Text("When fridge is opened")
                              .font(.title3)
                              .fontWeight(.medium)
                          
                          HStack {
                              Image(systemName: "hand.draw")
                                  .font(.system(size: 20))
                                  .frame(alignment: .trailing)
                              Text("Pull upwards to use search bar.")
                                  .font(.subheadline)
                          }
                          .padding(.top, 2)
                          
                          HStack {
                              Text("Click on it to add food.")
                                  .font(.subheadline)
                                  .padding(.leading, 40)
                              Image(systemName: "plus.square.fill")
                                  .resizable()
                                  .frame(width: 40, height: 40)
                                  .foregroundColor(Color("PrimaryColor"))
                                  .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                                  .rotationEffect(.degrees(4))
                                  .padding(.leading)
                          }
                          
                      }
                      .padding()
                  }
                  .cornerRadius(10)
                  .frame(width: 325, height: 400)
                  .background(
                       RoundedRectangle(cornerRadius: 5)
                           .fill(Color("BackgroundColor"))
                  )
                  .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 1, y: 1)
                       
                       
//                       grocery list
                       ZStack {
                           VStack(alignment: .leading) {
                               Text("Grocery list")
                                   .font(.title2)
                                   .fontWeight(.semibold)
                                   .frame(maxWidth: .infinity, alignment: .leading)

                               HStack {
                                   Image(systemName: "checkmark")
                                       .foregroundColor(Color.green)
                                       .font(.system(size: 20))
                                   Text("Double tap to check item.")
                                       .font(.subheadline)
                               }
                               .padding(.top, 5)
                               .padding(.leading, 20)
                               
                               HStack {
                                   Text("Swipe left to delete item.")
                                       .font(.subheadline)
                                   Image(systemName: "hand.draw")
                               }
                               .padding(.top, 2)
                               .padding(.leading, 80)
                               
                               HStack {
                                   Image(systemName: "hand.point.right")
                                   Text("Hold item to edit it.")
                                       .font(.subheadline)
                               }
                               .padding(.top, 2)
                               .padding(.leading, 40)
                               
                           }
                           .padding()
                       }
                       .cornerRadius(10)
                       .frame(width: 325, height: 400)
                       .background(
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color("BackgroundColor"))
                       )
                       .shadow(color: Color.gray.opacity(0.2), radius: 3, x: 1, y: 1)
                       
                       
                       
                       
                       
                       
    //                   ForEach(guidelines) { i in
    //
    ////                       GeometryReader { geometry in
    ////                           CardView(title: card.title, image: card.image, color: card.color)
    ////                               .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX - 50) / -30), axis: (x: 0, y: 100.0, z: 0))
    ////                       }
    //                       .frame(width: 250, height: 400)
    //                   }
                   }
                   .padding([.leading, .trailing], 30)
                   .padding(.bottom, 50)
                }

                
                
            }
            .navigationBarTitle("Settings")
                        
            VStack {
                Spacer()
                Button{
                    DataController().updateFridgeName(newFridgeName: fridgeName)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color.green)
                        .shadow(color: .gray, radius: 0.5, x: 1, y: 1)
                }
            }
        }
        
        
        
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
