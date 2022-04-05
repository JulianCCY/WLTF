//
//  FoodDetail.swift
//  WLTF
//
//  Created by iosdev on 5.4.2022.
//

import SwiftUI

struct FoodDetail: View {
    var body: some View {
        VStack {
            CircleImage()
                .offset(y: 75)
                .padding(.bottom, 75)

            VStack(alignment: .leading) {
                Text("Amount")
                    .font(.title)
                
                Text("Joshua Tree National Park")

                Divider()
                Group {
                    Text("Entry date")
                        .font(.title2)
                    Text("Descriptive text goes here.")
                        .padding(.bottom)
                }
                
                Group {
                    Text("Expiration date")
                        .font(.title2)
                    Text("Descriptive text goes here.")
                }
                
            }
            .padding()
        Spacer()
        }
    }
}

struct FoodDetail_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetail()
    }
}
