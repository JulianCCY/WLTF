//
//  MapModel.swift
//  WLTF
//
//  Created by iosdev on 27.4.2022.
//
// MapViewModel for mapkit

import SwiftUI
import MapKit
import CoreLocation

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var mapView = MKMapView()
    @Published var region: MKCoordinateRegion!
    @Published var permissionDenined = false
    @Published var mapType: MKMapType = .standard
    @Published var searchText = ""
    @Published var locations: [LocationStruct] = []
    
    let locationManager = CLLocationManager()
    
    override init() {
           super.init()
           locationManager.delegate = self
       }
    
//    focus user position
    func findYourself() {
        guard let _ = region else { return }
        
        mapView.setRegion(region, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
//    cheching maptype
    func updateMapType() {
        if mapType == .standard {
            mapType = .hybrid
            mapView.mapType = mapType
        } else {
            mapType = .standard
            mapView.mapType = mapType
        }
    }
    
//    let user search for places
    func searchPlaces() {
        
        locations.removeAll()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        MKLocalSearch(request: request).start { (response, _) in
            guard let result = response else { return }
            
            self.locations = result.mapItems.compactMap({ (i) -> LocationStruct? in
                return LocationStruct(place: i.placemark)
            })
        }
    }
    
//    focus the place when user select a searched place
    func selectPlace(location: LocationStruct) {
        
        searchText = ""
        
        guard let coordinate = location.place.location?.coordinate else { return }
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = location.place.name ?? "No name found"
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(pointAnnotation)
        
        let coordinateRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1800, longitudinalMeters: 1800)
        mapView.setRegion(coordinateRegion, animated: true)
        mapView.setVisibleMapRect(mapView.visibleMapRect, animated: true)
    }
    
//    request user location
    func requestLocation() {
        locationManager.requestLocation()
    }
    
//    checking user authorization status and request user location if permitted
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch manager.authorizationStatus {
        case .denied:
            permissionDenined.toggle()
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.requestLocation()
        default:
            ()
        }
    }
    
//   catch fail error
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
//    displaying user location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.first?.coordinate {
            
            self.region = MKCoordinateRegion(center: location, latitudinalMeters: 2500, longitudinalMeters: 2500)
            
            self.mapView.setRegion(self.region, animated: true)
            
            self.mapView.setVisibleMapRect(self.mapView.visibleMapRect, animated: true)

        }
    }
}
