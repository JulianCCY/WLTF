//
//  Settings.swift
//  WLTF
//
//  Created by iosdev on 24.4.2022.
//
// This is the setting page, also known as the guidelines, can be navigated from ClosedFridgeScreen
// This page can modify the fridge name, switch the language, and show the user about our app's functionalities

import SwiftUI

struct Settings: View {
    
//    coredata
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var fridgeName: String = DataController().fetchFridgeName()
    
//    using userdefaults for language selection
    @AppStorage("lang") private var chosenLanguage: String = "en"
    
    @State private var keyboardHeight: CGFloat = 0
    
//    environment locale cannot localize navigation bar title, that's why we need a funcition
    private func translate(input: String) -> String {
        if input == "en" {
            return "Settings"
        } else {
            return "Asetukset"
        }
    }
    
    var body: some View {
        
        ZStack {
            
            Color("TertiaryColor")
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
              
//                Naming the fridge
                VStack(alignment: .leading, spacing: 2) {
                    Text("name_your_fridge")
                        .font(.headline)
                    TextField("Name of your fridge", text: $fridgeName)
                        .foregroundColor(Color(UIColor.gray))
                }
                .padding()
            
//                language picker
                Picker("Select language", selection: $chosenLanguage) {
                    Text("English 🇬🇧")
                        .tag("en")
                    Text("Suomi 🇫🇮")
                        .tag("fi")
                }
                .pickerStyle(SegmentedPickerStyle())
                .colorMultiply(Color("Fridge"))
                .padding()
                
    //            guidelines
                ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 20) {
                       
    //                   general
                       ZStack {
                           VStack(alignment: .leading) {
                               Text("general")
                                   .font(.title2)
                                   .fontWeight(.semibold)
                               Spacer()
                               
                               HStack {
                                   RoundedRectangle(cornerRadius: 10)
                                       .fill(Color("NormalItem"))
                                       .frame(width: 50, height: 50)
                                       .rotationEffect(.degrees(-3))
                                   Text("normal_item")
                                       .font(.subheadline)
                               }
                               HStack {
                                   Spacer()
                                   Text("3_days_item")
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
                                   Text("1_day_item")
                                       .font(.subheadline)
                               }
                               HStack {
                                   Text("expired_item")
                                       .font(.subheadline)
                                   RoundedRectangle(cornerRadius: 10)
                                       .fill(Color("ExpiredItem"))
                                       .frame(width: 50, height: 50)
                                       .rotationEffect(.degrees(-4))
                               }
                               HStack {
                                   Image(systemName: "plus.rectangle")
                                       .font(.system(size: 20))
                                       .foregroundColor(Color("PrimaryColor"))
                                   Text("add_button")
                                       .font(.subheadline)
                               }
                               .padding(.bottom)
                               HStack{
                                   Text("gray_colored")
                                       .foregroundColor(Color(UIColor.gray))
                                       .font(.subheadline)
                                   Text("input_fields")
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
                          Text("home_page")
                              .font(.title2)
                              .fontWeight(.semibold)
                          
                          Text("closed_fridge")
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
                              Text("sticky_note_number")
                                  .font(.subheadline)
                          }
                          HStack {
                              Spacer()
                              Text("tap_on_fridge")
                                  .font(.subheadline)
                              Spacer()
                              Image(systemName: "hand.point.left")
                                  .font(.system(size: 20))
                                  .frame(alignment: .trailing)
                          }
                          .padding(.top, 5)
                          
                          Spacer()
                          
                          Text("opened_fridge")
                              .font(.title3)
                              .fontWeight(.medium)
                          
                          HStack {
                              Image(systemName: "hand.draw")
                                  .font(.system(size: 20))
                                  .frame(alignment: .trailing)
                              Text("search_bar")
                                  .font(.subheadline)
                          }
                          .padding(.top, 2)
                          
                          HStack {
                              Text("click_to_add_food")
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
                               Text("grocery_list")
                                   .font(.title2)
                                   .fontWeight(.semibold)
                                   .frame(maxWidth: .infinity, alignment: .leading)

                               HStack {
                                   Image(systemName: "checkmark")
                                       .foregroundColor(Color.green)
                                       .font(.system(size: 20))
                                   Text("double_tab")
                                       .font(.subheadline)
                               }
                               .padding(.top, 5)
                               .padding(.leading, 20)
                               
                               HStack {
                                   Text("swipe_delete")
                                       .font(.subheadline)
                                   Image(systemName: "hand.draw")
                               }
                               .padding(.top, 2)
                               .padding(.leading, 80)
                               
                               HStack {
                                   Image(systemName: "hand.point.right")
                                   Text("hold_edit")
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
                       
//                       Dishes
                     ZStack {
                         VStack(alignment: .leading) {
                             Text("dish")
                                 .font(.title2)
                                 .fontWeight(.semibold)
                                 .padding(.bottom, 40)
                             
                             HStack {
                                 Circle()
                                     .fill(Color("Green"))
                                     .frame(width: 16, height: 16)
                                 Text("represent_adequate")
                                     .font(.subheadline)
                             }
                             .padding(.leading, 10)
                             HStack {
                                 Circle()
                                     .fill(Color("Red"))
                                     .frame(width: 16, height: 16)
                                 Text("represent_inadequate")
                                     .font(.subheadline)
                             }
                             
                             HStack {
                                 Text("click_create_dish")
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
                             .padding(.bottom, 50)
                             
                             HStack {
                                 Image(systemName: "waveform.and.mic")
                                     .resizable()
                                     .padding(10)
                                     .frame(width: 50, height: 50)
                                     .foregroundColor(Color("TertiaryColor"))
                                     .background(Color("PrimaryColor"))
                                     .clipShape(Circle())
                                     .shadow(color: .gray, radius: 0.2, x: 1, y: 1)
                                     .rotationEffect(.degrees(-6))
                                 Text("click_speech")
                                     .font(.subheadline)
                                     .padding(.leading, 40)
                             }
                             .frame(maxWidth: .infinity)
                             .padding(.bottom, 10)
                             
                             HStack {
                                 Spacer()
                                 VStack {
                                     Text("\"What do you recommend to cook?\"")
                                     Text("\"Can I cook (dishname)?\"")
                                 }
                                 .font(.subheadline)
                                 Spacer()
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
                       
                   } // hstack
                   .padding([.leading, .trailing], 30)
                   .padding(.bottom, 50)
                } // scrollview
            } // main vstack
            .navigationBarTitle("\(translate(input: chosenLanguage))")
                    
//            save button
            VStack {
                Spacer()
                Button{
                    DataController().updateFridgeName(newFridgeName: fridgeName)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark.square.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("PrimaryColor"))
                }
            }
        } // big z
        .environment(\.locale, .init(identifier: chosenLanguage))
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
