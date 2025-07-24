//
//  LocationView.swift
//  MapAppSwift
//
//  Created by Djordje on 22. 7. 2025..
//

import SwiftUI
import MapKit

struct LocationView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 41.8902, longitude: 12.4922),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $vm.mapRegion)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                header
                    .padding(.horizontal)
                
                Spacer()
            }
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationsViewModel())
}

extension LocationView {
    
    private var header: some View {
        VStack {
            Button {
                vm.toggleLocationList()
            } label: {
                Text(vm.mapLocation.name + ", "
                     + vm.mapLocation.cityName)
                .font(.title2)
                .fontWeight(.black)
                .foregroundStyle(.primary)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .leading) {
                    if vm.showLocationList == true {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                    } else {
                        Image(systemName: "arrow.up")
                            .font(.headline)
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(.primary)
            }
            .foregroundStyle(.primary)

            if vm.showLocationList {
                LocationsListView()
            }
        }
        .background(.thickMaterial)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.3), radius: 20, x: 0, y: 16)
    }
}
