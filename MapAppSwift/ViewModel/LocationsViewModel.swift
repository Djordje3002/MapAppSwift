import SwiftUI
import MapKit

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    @Published var mapLocation: Location {
        didSet {
            updateMapRegion(location: mapLocation)
        }
    }
    @Published var mapRegion: MKCoordinateRegion
    
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    
    @Published var showLocationList: Bool = false
    
    @Published var sheetLocation: Location? = nil
    
    init() {
        let locations = LocationsDataService.locations
        let firstLocation = locations.first!
        
        self.locations = locations
        self.mapLocation = firstLocation
        self.mapRegion = MKCoordinateRegion(center: firstLocation.coordinates, span: mapSpan) // ✅ initialize here
        updateMapRegion(location: firstLocation)
    }
    
    private func updateMapRegion(location: Location) {
        withAnimation {
            mapRegion = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
        }
    }
    
    func toggleLocationList() {
        withAnimation(.easeInOut) {
            showLocationList.toggle()
        }
    }
    
    func showNextLocation(location: Location) {
        withAnimation(.easeInOut) {
            mapLocation = location
            showLocationList = false
        }
    }
    
    func nextButtonPressed() {
        guard let currentIndex = locations.firstIndex(where: {
            $0 == mapLocation
        }) else {
            return
        }
        
        let nextIndex = (currentIndex + 1)
        guard locations.indices.contains(nextIndex) else {
            
            guard let firstLocation = locations.first else {
                return
            }
            showNextLocation(location: firstLocation)
            return
        }
        let nextLocation = locations[nextIndex]
        showNextLocation(location: nextLocation)
    }
}

