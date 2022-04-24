//
//  MapController.swift
//  WLTF
//
//  Created by Chan Chung Yin on 23/4/2022.
//

import Foundation
import MapKit
import CoreLocation

// default location
enum mapDefault {
    static let defaultCenter = CLLocationCoordinate2D(latitude: 60.219117380243496, longitude: 24.81039366986794)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    // init region
    @Published var region = MKCoordinateRegion(
        center: mapDefault.defaultCenter,
        span: mapDefault.defaultSpan
        )
    
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            checkLocationAuthorisation()
//            let filter = MKPointOfInterestFilter.excludingAll
            
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
//            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
//                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            region = MKCoordinateRegion(center: mapDefault.defaultCenter,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorisation()
    }
}
