//
//  LocationViewModel.swift
//  MapAppSwift
//
//  Created by Djordje on 22. 7. 2025..
//

import SwiftUI

class LocationsViewModel: ObservableObject {
    @Published var locations: [Location]
    
    init() {
        let locations = LocationsDataService.locations
        self.locations = locations
    }
    
}
