//
//  LocationManager.swift
//  DineDecide
//
//  Created by Charlotte Lew on 4/25/25.
//

import Foundation
import CoreLocation

@Observable class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    var userLocation: CLLocation?
    var userLocationString: String = "locating user's location..."
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func getUserLocationString() -> String {
        return userLocationString
    }
    func requestLocation() {
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        userLocationString = "got permission but waiting"
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.first
        userLocationString = "Lat: \(userLocation!.coordinate.latitude), Long: \(userLocation!.coordinate.longitude)"
        print("didUpdateLocations called with \(locations.count) locations")
        print("Received location: \(userLocationString)")


    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }
}
