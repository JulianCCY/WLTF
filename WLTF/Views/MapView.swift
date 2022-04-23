//
//  MapView.swift
//  WLTF
//
//  Created by iosdev on 4.4.2022.
//

import SwiftUI
import MapKit

struct MapView: View {
    @StateObject private var mapViewModel = MapViewModel()
    
    var body: some View {
        Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true)
            .ignoresSafeArea()
//            .accentColor(Color("Secondary"))
            .onAppear{
                mapViewModel.checkIfLocationServicesIsEnabled()
            }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
