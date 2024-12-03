//
//  EditViewModel.swift
//  BucketList
//
//  Created by Xristos Mantsos on 3/12/24.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

extension EditView {
    @Observable
    class ViewModel {
        var loadingState = LoadingStates.loading
        var pages = [Page]()
        var name: String
        var description: String
        var location: Location

        init(location: Location) {
            self.name = location.name
            self.description = location.description
            self.location = location
        }

        enum LoadingStates {
            case loading, loaded, failed
        }

        func fetchNearbyPlaces(location: Location) async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.latitude)%7C\(location.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                pages = items.query.pages.values.sorted()
                loadingState = .loaded
            } catch {
                loadingState = .failed
            }
        }
    }
}
