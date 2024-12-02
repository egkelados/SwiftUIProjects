//
//  MapKitIntergration.swift
//  BucketList
//
//  Created by Xristos Mantsos on 2/12/24.
//
import MapKit
import SwiftUI

struct Location1: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct MapKitIntergration: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    )

    let location = [
        Location1(name: "Buckinham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),

        Location1(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]

    var body: some View {
        VStack {
//            Map {
//                ForEach(location) { location in
            ////                    Marker(location.name, coordinate: location.coordinate)
//                    Annotation(location.name, coordinate: location.coordinate) {
//                        Text(location.name)
//                            .font(.title)
//                            .padding()
//                            .background(.blue.gradient)
//                            .foregroundStyle(.white)
//                            .clipShape(.capsule)
//                    }
//                    .annotationTitles(.hidden)
//                }
//            }

            MapReader { proxy in
                Map()
                    .onTapGesture { position in
                        if let coordinates = proxy.convert(position, from: .local) {
                            print(coordinates)
                        }
                    }
            }
        }
    }
}

struct MapKitIntergrationDemo: View {
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
    )

    let location = [
        Location1(name: "Buckinham Palace", coordinate: CLLocationCoordinate2D(latitude: 51.501, longitude: -0.141)),

        Location1(name: "Tower of London", coordinate: CLLocationCoordinate2D(latitude: 51.508, longitude: -0.076))
    ]

    var body: some View {
        VStack {
            //        Map(interactionMode: [.rotate, .zoom])
            //        Map(interactionModes: [])
            Map(position: $position)
                .mapStyle(.hybrid(elevation: .realistic))
                .onMapCameraChange(frequency: .continuous) { context in
                    print(context.region)
                }
            HStack(spacing: 20) {
                Button("Paris") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }

                Button("Tokyo") {
                    position = MapCameraPosition.region(
                        MKCoordinateRegion(
                            center: CLLocationCoordinate2D(latitude: 35.6897, longitude: 139.6922),
                            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
                        )
                    )
                }
            }
        }
    }
}

#Preview {
    MapKitIntergration()
}
