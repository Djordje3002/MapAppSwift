//
//  LocationDetailView.swift
//  MapAppSwift
//
//  Created by Djordje on 25. 7. 2025..
//

import SwiftUI
import MapKit

struct LocationDetailView: View {
    
    let location: Location
    @EnvironmentObject private var vm: LocationsViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading, spacing: 16.0) {
                    imageSection
                    titleSection
                    Divider()
                    descriptionSection
                    Divider()
                    mapLayer
                }
                .overlay (
                    backButton,
                    alignment: .topLeading
                )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LocationDetailView(location: LocationsDataService.locations.first!)
        .environmentObject(LocationsViewModel())
}


extension LocationDetailView {
    
    private var imageSection: some View {
        TabView {
            ForEach(location.imageNames, id: \.self) {
                Image($0)
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIDevice.current.userInterfaceIdiom == .pad ? nil : UIScreen.main.bounds.width)
                    .clipped()
            }
                .shadow(color: .black.opacity(0.3), radius: 20, x: 20, y: 10)
        }
        .frame(height: 500)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(location.name)
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text(location.cityName)
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
    
    private var descriptionSection: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(location.description)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            if let url = URL(string: location.link) {
                Link("Read more on Wikipedia", destination: url)
                    .tint(.blue)
            }
        }

        .padding()
    }
    
    private var mapLayer: some View {
        Map(
            coordinateRegion: .constant(
                MKCoordinateRegion(center: location.coordinates, span: vm.mapSpan)
            ),
            annotationItems: [location]
        ) { location in
            MapAnnotation(coordinate: location.coordinates) {
                AnotationView()
                    .scaleEffect(vm.mapLocation == location ? 1 : 0.7)
                    .shadow(radius: 10)
                    .onTapGesture {
                        vm.showNextLocation(location: location)
                    }
            }
        }
        .allowsHitTesting(false)
        .aspectRatio(1, contentMode: .fit)
        .cornerRadius(10)
        .padding()
    }
    
    private var backButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark")
                .font(.headline)
                .padding(16)
                .foregroundStyle(.primary)
                .background(.thickMaterial)
                .shadow(radius: 4)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding(.top, 32)
                .padding(.leading)
        }
    }
    
}
