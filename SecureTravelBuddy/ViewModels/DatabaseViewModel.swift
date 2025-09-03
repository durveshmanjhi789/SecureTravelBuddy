//
//  DatabaseViewModel.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import Foundation
import MapKit

@MainActor

class DatabaseViewModel:ObservableObject{
    @Published var places:[Place] = []
    
    func addPlace(name:String,latitude:Double,longitude:Double){
        let place = Place(name: name, coordinate: CLLocationCoordinate2D(latitude: latitude, longitude:longitude))
        places.append(place)
        LocalDatabaseService.shared.savePlace(name: name, latitude: latitude, longitude: longitude)
        
    }
    
    func loadPlaces(){
        places = LocalDatabaseService.shared.fetchPlaces()
    }
    
}
