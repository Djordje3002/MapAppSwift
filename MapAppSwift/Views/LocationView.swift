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
            mapLayer
            VStack(spacing: 0) {
                header
                    .padding(.horizontal)
                Spacer()
                locationsPreviewStack
            }
        }
        .sheet(item: $vm.sheetLocation, onDismiss: nil) { location in
            LocationDetailView(location: location)
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
                .animation(.none, value: vm.mapLocation)
                .overlay(alignment: .leading) {
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .padding(.horizontal)
                            .foregroundStyle(.primary)
                            .rotationEffect(Angle(degrees: vm.showLocationList ? 180 : 0))
                }
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
    
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.locations) { location in
            MapAnnotation(coordinate: location.coordinates) {
                AnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
    }
    
    private var locationsPreviewStack: some View {
        ZStack {
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .shadow(color: Color.black.opacity(0.3), radius: 20)
                        .padding()
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
                }
            }
        }
    }
    
}
