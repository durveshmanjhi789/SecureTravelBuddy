//
//  AnnotationItem.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 04/09/25.
//
import Foundation
import CoreLocation
// MARK: - Annotation Item
struct AnnotationItem: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    let name: String
}
