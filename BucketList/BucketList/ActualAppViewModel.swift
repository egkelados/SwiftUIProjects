//
//  ActualAppViewModel.swift
//  BucketList
//
//  Created by Xristos Mantsos on 2/12/24.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ActualAppView {
    @Observable
    class ViewModel {
        var selectedPlace: Location?
        private(set) var locations: [Location]
        var updateTrigger = false
        var isUnlocked = false

        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Undable to save data...")
            }
        }

        func addLocation(at point: CLLocationCoordinate2D) {
            if let existingLocation = locations.first(where: { $0.coordinate.isCloseTo(point) }) {
                locations.removeAll { $0.id == existingLocation.id }
            } else {
                let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
                locations.append(newLocation)
            }
            save()
            updateTrigger.toggle() // Trigger a UI refresh
        }

        func removeLocation(at coordinate: CLLocationCoordinate2D) {
            if let existingLocation = locations.first(where: { $0.coordinate.isCloseTo(coordinate) }) {
                locations.removeAll { $0.id == existingLocation.id }
                save()
                updateTrigger.toggle() // Trigger a UI refresh
            }
        }

        func updateLocation(location: Location) {
            guard let selectedPlace else { return }
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places"

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, _ in
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            } else {
                // no biometricks
            }
        }
    }
}
