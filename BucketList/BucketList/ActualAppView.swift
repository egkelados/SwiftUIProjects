//
//  ActualAppView.swift
//  BucketList
//
//  Created by Xristos Mantsos on 2/12/24.
//

import MapKit
import SwiftUI

struct ActualAppView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 56, longitude: -3), span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10))
    )

    @State private var viewModel = ViewModel()

    var body: some View {
        if viewModel.isUnlocked {
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    ForEach(viewModel.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(.circle)
                                .onLongPressGesture {
                                    viewModel.selectedPlace = location
                                }
                        }
                    }
                }
                .mapStyle(.hybrid)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        if let _ = viewModel.locations.first(where: { $0.coordinate.isCloseTo(coordinate) }) {
                            viewModel.removeLocation(at: coordinate)
                        } else {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                }
                .onChange(of: viewModel.updateTrigger) { _, _ in
                    // Forces a UI refresh by observing the toggle
                }
                .sheet(item: $viewModel.selectedPlace) { place in
                    EditView(location: place) {
                        viewModel.updateLocation(location: $0)
                    }
                }
            }
        } else {
            Button("Unlock places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
        }
    }
}

#Preview {
    ActualAppView()
}
