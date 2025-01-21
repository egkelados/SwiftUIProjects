//
//  Facility.swift
//  SnowSeeker
//
//  Created by Xristos Mantsos on 15/1/25.
//

import SwiftUI

struct Facility: Identifiable {
    let id = UUID()
    var name: String

    private let icons = [
        "Accommodation": "house",
        "Beginners": "1.circle",
        "Cross-country": "map",
        "Eco-friendly": "leaf.arrow.circlepath",
        "Family": "person.3",
    ]

    private let descriptions = [
        "Accommodation": "This resort has popular on-site accomodation",
        "Beginners": "This resort has lots of ski schools",
        "Cross-country": "This resort has many cross-country ski routes",
        "Eco-friendly": "This resort has won an award for environment friendliness",
        "Family": "This resort is populare with families",
    ]

    var icon: some View {
        if let iconName = icons[name] {
            return Image(systemName: iconName)
                .accessibilityLabel(name)
                .foregroundStyle(.secondary)

        } else {
            fatalError("Unkown facility type: \(name)")
        }
    }

    var description: String {
        if let descriptionName = descriptions[name] {
            descriptionName
        } else {
            fatalError("Unkown facility type: \(name)")
        }
    }
}
