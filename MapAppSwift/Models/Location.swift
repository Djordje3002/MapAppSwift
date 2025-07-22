//
//  Location.swift
//  MapAppSwift
//
//  Created by Djordje on 22. 7. 2025..
//
import SwiftUI

struct Location: Identifiable {
    name: "Eiffel Tower",
    cityName: "Paris",
    coordinates: CLLocationCoordinate2D(latitude: 48.8584, longitude: 2.2945),
    description: "The Eiffel Tower is a wrought-iron lattice tower on the Champ de Mars in Paris, France. It is named after the engineer Gustave Eiffel, whose company designed and built the tower. Locally nicknamed 'La dame de fer', it was constructed from 1887 to 1889 as the centerpiece of the 1889 World's Fair and was initially criticized by some of France's leading artists and intellectuals for its design, but it has become a global cultural icon of France and one of the most recognizable structures in the world.",
    imageNames: [
        "paris-eiffeltower-1",
        "paris-eiffeltower-2",
    ],
    link: "https://en.wikipedia.org/wiki/Eiffel_Tower"
}

