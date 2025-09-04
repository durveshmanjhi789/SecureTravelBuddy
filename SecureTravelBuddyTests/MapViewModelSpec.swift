//
//  MapViewModelSpec.swift
//  SecureTravelBuddyTests
//
//  Created by Durvesh Manjhi on 04/09/25.
//
//import XCTest
import Quick
import Nimble
@testable import SecureTravelBuddy
import CoreLocation

class MapViewModelSpec: QuickSpec {
    override class func spec() {
        var viewModel: MapViewModel!
        
        beforeEach {
            viewModel = MapViewModel()
        }
        
        describe("updateCurrentLocation") {
            it("updates currentCoordinate and annotationItems") {
                let testCoordinate = CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025)
                
                waitUntil(timeout: .seconds(5)) { done in
                    Task {
                        await viewModel.updateCurrentLocation(testCoordinate)
                        expect(viewModel.currentCoordinate.latitude).to(equal(28.7041))
                        expect(viewModel.annotationItems.last?.coordinate.latitude).to(equal(28.7041))
                        done()
                    }
                }
            }
        }
        
        describe("addAnnotation") {
            it("adds annotation with correct name") {
                let coordinate = CLLocationCoordinate2D(latitude: 28.7, longitude: 77.1)
                viewModel.addAnnotation(coordinate: coordinate, name: "Test Place")
                expect(viewModel.annotationItems.last?.name).to(equal("Test Place"))
            }
        }
        
        describe("getCityName") {
            it("returns a non-empty string for a valid coordinate") {
                waitUntil(timeout: .seconds(5)) { done in
                    Task {
                        let city = await viewModel.getCityName(for: CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025))
                        expect(city).toNot(beEmpty())
                        done()
                    }
                }
            }
        }
    }
}
