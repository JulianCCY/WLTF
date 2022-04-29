//
//  NotesUI.swift
//  WLTF
//
//  Created by iosdev on 20.4.2022.
//

import SwiftUI

struct NotesUI: View {
    
    func initialize(){
            UITableView.appearance().backgroundColor = .clear
            UITableViewCell.appearance().backgroundColor = .clear
            UITableView.appearance().tableFooterView = UIView()
     }
    
    @Binding var note: String
    @Binding var show: Bool
    @Binding var arr: [FoodStruct]
    
    private func img() -> String {
        if (note == "3days") {
            return "Orange note"
        }
        if (note == "1day") {
            return "Red note"
        }
        if (note == "expired") {
           return "Purple note"
        }
        else {
            return ""
        }
    }
    
    var body: some View {
        ZStack {
            if show {

                Image(img())
                    .resizable()
                    .frame(width: 390, height: 390)
                    .overlay(
                        ZStack {
                            VStack {
                                VStack {
                                    HStack {
                                        Button {
                                            show.toggle()
                                        } label: {
                                            Label("Back", systemImage: "arrow.uturn.left")
                                                .font(.custom("Marker Felt", size: 20))
                                                .foregroundColor(Color.black)
                                        }
                                        .padding(EdgeInsets(top: 12, leading: 30, bottom: 0, trailing: 0))
                                        Spacer()
                                    }
//                                    Spacer()
                                }

                                List(arr, id: \.self) { food in
                                    ZStack {
                                        HStack {
                                            Image("\(FoodImgFunc.selectImg(food.name, food.category))")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                            Spacer()
                                                .frame(width: 30)
                                            VStack {
                                                Text("\(food.name)")
                                                    .font(.custom("Bradley Hand", size: 20))
                                                Text("\(formattingForMemo(currentDate: food.expiryDate))")
                                                    .font(.custom("Bradley Hand", size: 20))
                                            }
                                            Spacer()
                                            Text("\(Int(food.amount)) \(food.unit)")
                                                .font(.custom("Bradley Hand", size: 20))
                                        }
                                    }
                                    .listRowBackground(Color.clear)
                                    .listRowSeparator(.hidden)
                                }
                                .listStyle(InsetListStyle())
                                .frame(width: 340, height: 300)
                                .onAppear{
                                      self.initialize()
                                }
                                
                                Spacer()
                                
                            }
//                            zstack
                        }
                    )
            }
        }
    }
}

//struct NotesUI_Previews: PreviewProvider {
//    static var previews: some View {
//        NotesUI(note: "3days")
//    }
//}
