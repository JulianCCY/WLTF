//
//  MapController.swift
//  WLTF
//
//  Created by Chan Chung Yin on 23/4/2022.
//

import Foundation
import MapKit

enum mapDefault {
    static let defaultCenter = CLLocationCoordinate2D(latitude: 60.219117380243496, longitude: 24.81039366986794)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(
        center: mapDefault.defaultCenter,
        span: mapDefault.defaultSpan
        )
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("Please open your location service")
        }
    }
    
    private func checkLocationAuthorisation() {
        guard let locationManager = locationManager else {
            return
        }
        
        switch locationManager.authorizationStatus {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted:
            print("permission is restricted")
            
        case .denied:
            print("You have denied your location permission")
            
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorisation()
    }
}
