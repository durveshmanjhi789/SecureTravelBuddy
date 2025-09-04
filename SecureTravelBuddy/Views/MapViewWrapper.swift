//
//  MapViewWrapper.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 04/09/25.
//
import SwiftUI
import MapKit

struct MapViewWrapper: UIViewRepresentable {
    @ObservedObject var vm: MapViewModel
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
        mapView.isPitchEnabled = true
        
        mapView.showsUserLocation = true
        mapView.setRegion(region(from: vm.cameraPosition), animated: true)
        
        //  Add gesture recognizer for dropping pins
//        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleLongPress(_:)))
//        mapView.addGestureRecognizer(longPress)
        
        return mapView
    }
 

    func updateUIView(_ uiView: MKMapView, context: Context) {

        uiView.setRegion(region(from: vm.cameraPosition), animated: true)
        
        // Remove old annotations

        uiView.removeAnnotations(uiView.annotations)

        // Add dynamic annotations
        for item in vm.annotationItems {
            let annotation = MKPointAnnotation()
            annotation.coordinate = item.coordinate
            annotation.title = item.name
            uiView.addAnnotation(annotation)
        }

    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapViewWrapper
        init(_ parent: MapViewWrapper) { self.parent = parent }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            //parent.vm.currentCoordinate = mapView.centerCoordinate
            let newCoordinate = mapView.centerCoordinate
               Task {// @MainActor in
                  // parent.vm.currentCoordinate = newCoordinate
                   await self.parent.vm.updateCurrentLocation(newCoordinate)

               }
        }
        //  Drop pin on long press
//        @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
//            guard gesture.state == .began,
//                  let mapView = gesture.view as? MKMapView else { return }
//            
//            let location = gesture.location(in: mapView)
//            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
//            
//            Task { @MainActor in
//                let city = await parent.vm.getCityName(for: coordinate)
//                parent.vm.addAnnotation(coordinate: coordinate, name: city)
//            }
//        }
    }
    
    private func region(from camera: MapCameraPosition) -> MKCoordinateRegion {
        return camera.region ?? MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 28.6139, longitude: 77.2090),
                                                   
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    }
    
    // Customize annotation view
         func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
             if annotation is MKUserLocation {
                 // Default blue dot for user location
                 return nil
             }
             let identifier = "CustomPin"
             var view = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
             if view == nil {
                 view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                 view?.canShowCallout = true
                 view?.markerTintColor = .red
             } else {
                 view?.annotation = annotation
             }
             return view
         }
    // Helper to compare regions (avoid re-setting if user moves map slightly)
    private func regionsAreEqual(_ lhs: MKCoordinateRegion, _ rhs: MKCoordinateRegion) -> Bool {
        abs(lhs.center.latitude - rhs.center.latitude) < 0.0001 &&
        abs(lhs.center.longitude - rhs.center.longitude) < 0.0001 &&
        abs(lhs.span.latitudeDelta - rhs.span.latitudeDelta) < 0.0001 &&
        abs(lhs.span.longitudeDelta - rhs.span.longitudeDelta) < 0.0001
    }
}
