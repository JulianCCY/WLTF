//
//  CircleImage.swift
//  WLTF
//
//  Created by iosdev on 4.4.2022.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        Image("Landing page logo")
            .clipShape(Circle())
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
