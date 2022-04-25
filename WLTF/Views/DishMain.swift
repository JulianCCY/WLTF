//
//  DishMain.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//

import SwiftUI

struct DishMain: View {
    
    @State private var dishArr: [String] = ["Fries", "Noodles", "Rice", "Pizza", "Steak", "Pasta"]
    
    var body: some View {
        ZStack {
            VStack {
    //            guidelines
                ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 20) {
                       
                       ForEach(dishArr, id: \.self) { i in
    
                           GeometryReader { geometry in
                               DishCard(title: i)
                                   .rotation3DEffect(Angle(degrees: Double(geometry.frame(in: .global).minX) / 10), axis: (x: 0, y: 0, z: 1000))
                           }
                           .frame(width: 180, height: 180)
                       }
                   }
                   .padding([.leading, .trailing], 30)
                   .padding(.bottom, 50)
                }

            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
}

struct DishMain_Previews: PreviewProvider {
    static var previews: some View {
        DishMain()
    }
}
