//
//  EditAlert.swift
//  WLTF
//
//  Created by iosdev on 21.4.2022.
//

import SwiftUI

struct EditAlert: View {
    @Binding var text1: String
    @Binding var text2: String
    @Binding var showingAlert: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.8))
            VStack {
                Text("Edit item")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                TextField("Enter text", text: $text1)
                    .padding(5)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    
                TextField("Enter text", text: $text2)
                    .padding(5)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                
                Divider()
                
                HStack {
                    HStack {
                        Spacer()
                        Button("Cancel") {
                            self.showingAlert.toggle()
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button ("Save") {
                            print("New food \(text1) \(text2)")
                            self.showingAlert.toggle()
                        }
                        Spacer()
                    }
                }
            }
            .padding()
        }.frame(width: UIScreen.main.bounds.width-80, height: 10)
//        .background(Color.black.opacity(0.5))
//         .cornerRadius(12)
//         .clipped()
    }
}
//struct EditAlert_Previews: PreviewProvider {
//    static var previews: some View {
//        EditAlert(text1: "", text2: "", showingAlert: )
//    }
//}
