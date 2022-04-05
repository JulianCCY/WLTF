//
//  ContentView.swift
//  WLTF
//
//  Created by iosdev on 3.4.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        VStack (alignment: .leading) {
            Text("What Left The Fridge")
                .font(.title)
                .foregroundColor(.black)
            HStack {
                Text("Your personal fridge manager")
                    .font(.subheadline)
                Spacer()
                Text("Swift UI test")
                    .font(.subheadline)
            }
        }
        .padding()
    }
}

struct ContentView_Previews:
    PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
