//
//  DishMain.swift
//  WLTF
//
//  Created by iosdev on 18.4.2022.
//

import SwiftUI

struct DishMain: View {
    var body: some View {
        ZStack {
            VStack {
    //            guidelines
                ScrollView(.horizontal, showsIndicators: false) {
                   HStack(spacing: 20) {
                       

                       

                       
                       
                       
                       
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
