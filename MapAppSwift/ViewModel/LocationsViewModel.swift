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
}

