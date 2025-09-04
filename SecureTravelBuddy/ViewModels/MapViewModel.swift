//
//  MapViewModel.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import MapKit
import SwiftUI

class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var cameraPosition: MapCameraPosition
    @Published var currentCoordinate: CLLocationCoordinate2D 
//    @Published var selectedCoordinate: CLLocationCoordinate2D? = nil
    @Published var annotationItems: [AnnotationItem] = []

    private let geocoder = CLGeocoder()
    private let manager = CLLocationManager()
    private var hasCenteredOnce = false   // <— to stop snapping back

    
    override init(){
        // Initial camera position (Delhi)
        let initialCoordinate = CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090)
        self.cameraPosition = .region(MKCoordinateRegion(center: initialCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
        self.currentCoordinate = initialCoordinate
        
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
     
    // CLLocationManager delegate
    nonisolated func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Update camera position with region
        Task { await updateCurrentLocation(location.coordinate) }
        
    }
    // Reverse geocode to get city name
       func getCityName(for coordinate: CLLocationCoordinate2D) async -> String {
           let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
           do {
               let placemarks = try await geocoder.reverseGeocodeLocation(location)
               if let city = placemarks.first?.locality {
                   return city
               } else if let name = placemarks.first?.name {
                   return name
               }
           } catch {
               print("Geocode error: \(error.localizedDescription)")
           }
           return "Unknown Place"
       }
    func addAnnotation(coordinate: CLLocationCoordinate2D, name: String? = nil) {
        let item = AnnotationItem(coordinate: coordinate, name: name ?? "Pinned Place")
         annotationItems.append(item)
        
     }
    
    func updateCurrentLocation(_ coordinate: CLLocationCoordinate2D) async {
//        let cityName = await getCityName(for: coordinate)
        await MainActor.run {
            
            self.currentCoordinate = coordinate
            self.cameraPosition = .region(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
            
            // Keep only one "Current Location" pin
            self.annotationItems.removeAll(where: { $0.name == "Current Location" })
            let current = AnnotationItem(coordinate: coordinate, name: "Current Location")
            self.annotationItems.append(current)
            
        }
    }
  
}
   
