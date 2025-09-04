//
//  MapView.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 03/09/25.
//

import SwiftUI
import MapKit
//import Quick
//import Nimble


struct MapView: View {
    @StateObject private var vm = MapViewModel()
    @StateObject private var dbVM = DatabaseViewModel()
    @State private var showSavedPlaces = false
    
    var body: some View{
        VStack{
            MapViewWrapper(vm: vm)
                           .edgesIgnoringSafeArea(.all)
            HStack {
                Button("Save Current Place") {
                    Task {
                        let city = await vm.getCityName(for: vm.currentCoordinate)
                            dbVM.addPlace(name: city,
                                          latitude: vm.currentCoordinate.latitude,
                                          longitude: vm.currentCoordinate.longitude)
                     
                    }

                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Button("View Saved Places") {
                    showSavedPlaces = true
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
        }
        .sheet(isPresented: $showSavedPlaces) {
            SavedPlacesView()
        }
        .onAppear {
            dbVM.loadPlaces()
        }
    }
}


