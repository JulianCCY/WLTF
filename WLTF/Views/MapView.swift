//
//  MapView.swift
//  WLTF
//
//  Created by iosdev on 4.4.2022.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
//    @StateObject private var mapViewModel = MapViewModel()
////    mapViewModel.pointOfInterest = MKPointOfInterestFilter.excludingAll
//
//    var body: some View {
//        Map(coordinateRegion: $mapViewModel.region, showsUserLocation: true)
//            .ignoresSafeArea()
////            .accentColor(Color("Secondary"))
//            .onAppear{
//                mapViewModel.checkIfLocationServicesIsEnabled()
//            }
//    }
    
    @EnvironmentObject var mapData: MapViewModel
    
    func makeCoordinator() -> Coordinator {
        return MapView.Coordinator()
    }
    
    func makeUIView(context: Context) -> MKMapView {
        
        let view = mapData.mapView
        
        view.showsUserLocation = true
        view.delegate = context.coordinator
        
        return view
        
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        private func mapView(_ mapView: MapView, viewfor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation.isKind(of: MKUserLocation.self) { return nil }
            else {
                let pinAnnotation = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "PIN_VIEW")
                pinAnnotation.tintColor = .red
                pinAnnotation.animatesDrop = true
                pinAnnotation.canShowCallout = true
                
                return pinAnnotation
            }
        }
        
    }
    
}

