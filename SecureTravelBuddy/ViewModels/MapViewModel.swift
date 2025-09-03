//
//  MapViewModel.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import MapKit
import SwiftUI

@MainActor
class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05 ) )
    private let manager = CLLocationManager()
    
    override init(){
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            region.center = location.coordinate
        }
    }
}
