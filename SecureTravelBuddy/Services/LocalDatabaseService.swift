//
//  LocalDatabaseService.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import CoreData
import Foundation
import CoreLocation


class LocalDatabaseService{
    
    static let shared = LocalDatabaseService()
    
    let container:NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "SecureTravelBuddyModel")
        container.loadPersistentStores { _ , error in
            if let error = error {
                fatalError("Core data Load\(error)")
            }
        }
    }
    
    func savePlace(name: String, latitude: Double, longitude: Double) {
        let context = container.viewContext
        let place = PlaceEntity(context: context)
        place.name = name
        place.latitude = latitude
        place.longitude = longitude
        try? context.save()
        
    }
    
    func fetchPlaces() -> [Place] {
        let request:NSFetchRequest<PlaceEntity> = PlaceEntity.fetchRequest()
        
        if let results = try? container.viewContext.fetch(request){
            return results.map{Place(name: $0.name ?? "", coordinate: CLLocationCoordinate2D(latitude: $0.latitude, longitude: $0.longitude))
                
            }
        }
        return []
        
    }
    
}
