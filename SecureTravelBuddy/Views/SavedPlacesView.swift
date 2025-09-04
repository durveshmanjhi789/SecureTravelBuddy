//
//  SavedPlacesView.swift
//  SecureTravelBuddy
//
//  Created by Durvesh Manjhi on 04/09/25.
//

import SwiftUI

struct SavedPlacesView:View{
    @StateObject private var vm = DatabaseViewModel()
    var body: some View {
           NavigationView {
               List(vm.places) { place in
                   VStack(alignment: .leading) {
                       Text(place.name).bold()
                       Text("Lat: \(place.coordinate.latitude), Lon: \(place.coordinate.longitude)")
                           .font(.caption)
                           .foregroundColor(.gray)
                   }
               }
               .navigationTitle("Saved Places")
               .onAppear {
                   vm.loadPlaces()
               }
           }
       }
   }
