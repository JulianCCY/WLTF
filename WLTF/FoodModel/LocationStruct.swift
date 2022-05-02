//
//  LocationStruct.swift
//  WLTF
//
//  Created by iosdev on 28.4.2022.
//
// Structure for location object used for searching on MapScreen

import SwiftUI
import MapKit

struct LocationStruct: Identifiable {
    
    var id = UUID().uuidString
    var place: CLPlacemark
}
