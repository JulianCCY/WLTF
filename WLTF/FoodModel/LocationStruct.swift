//
//  LocationStruct.swift
//  WLTF
//
//  Created by iosdev on 28.4.2022.
//

import SwiftUI
import MapKit

struct LocationStruct: Identifiable {
    
    var id = UUID().uuidString
    var place: CLPlacemark
}
