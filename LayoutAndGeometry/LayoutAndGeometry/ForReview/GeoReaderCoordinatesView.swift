//
//  GeoReaderCoordinatesView.swift
//  LayoutAndGeometry
//
//  Created by Xristos Mantsos on 13/1/25.
//

import SwiftUI

struct OuterView: View {
    var body: some View {
        VStack {
            Text("Top")
            
            InnerView()
                .background(.green)
            
            Text("Bottom")
        }
    }
}

struct InnerView: View {
    var body: some View {
        HStack {
            Text("Left")
            
            GeometryReader { proxy in
                Text("Center")
                    .background(.blue)
                    .onTapGesture {
                        print("Global center \(proxy.frame(in: .global).midX) x \(proxy.frame(in: .global).midY) ")
                        print("Custom center \(proxy.frame(in: .named("Custom")).midX) x \(proxy.frame(in: .named("Custom")).midY) ")
                        print("Local center \(proxy.frame(in: .local).midX) x \(proxy.frame(in: .local).midY) ")
                    }
            }
            .background(.orange)
            Text("Right")
        }
    }
}

struct GeoReaderCoordinatesView: View {
    var body: some View {
        OuterView()
            .background(.red)
            .coordinateSpace(name: "Custom")
    }
}

#Preview {
    GeoReaderCoordinatesView()
}