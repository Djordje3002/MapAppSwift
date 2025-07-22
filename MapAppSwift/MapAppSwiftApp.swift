//
//  MapAppSwiftApp.swift
//  MapAppSwift
//
//  Created by Djordje on 22. 7. 2025..
//

import SwiftUI

@main
struct MapAppSwiftApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationView()
                .environmentObject(vm)
        }
    }
}
