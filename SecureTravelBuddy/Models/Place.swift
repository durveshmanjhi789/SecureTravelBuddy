//
//  Place.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//
import Foundation
import CoreLocation


struct Place: Identifiable,Codable{
    var id = UUID()
    var name:String
    var coordinate:CLLocationCoordinate2D
    
    enum CodingKeys:String,CodingKey{
        case id,name,latitude, longitude
    }
    // Encode CLLocationCoordinate2D manually

    func encode(to encoder:Encoder) throws{
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(coordinate.latitude, forKey: .latitude)
        try container.encode(coordinate.longitude, forKey: .longitude)
    }
    
    // Decode CLLocationCoordinate2D manually

    init(from decoder:Decoder) throws{
        var container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
    }
    
    init(name:String,coordinate:CLLocationCoordinate2D){
        self.name = name
        self.coordinate = coordinate
    }
    
}
