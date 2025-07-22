//
//  LocationView.swift
//  MapAppSwift
//
//  Created by Djordje on 22. 7. 2025..
//

import SwiftUI

struct LocationView: View {
    
    @EnvironmentObject private var vm: LocationsViewModel
    
    var body: some View {
        List {
            ForEach(vm.locations) {
                Text($0.name)
            }
        }
    }
}

#Preview {
    LocationView()
        .environmentObject(LocationsViewModel())
}
