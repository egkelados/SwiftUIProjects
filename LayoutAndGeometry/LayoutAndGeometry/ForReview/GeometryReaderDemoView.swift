//
//  GeometryReaderDemoView.swift
//  LayoutAndGeometry
//
//  Created by Xristos Mantsos on 13/1/25.
//

import SwiftUI

struct GeometryReaderDemoView: View {
    var body: some View {
        HStack {
            Text("Important")
                .frame(width: 200)
                .background(.blue)
            
            GeometryReader { proxy in
                Image(.screenshot20250113At13425PM)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.8)
                    .frame(width: proxy.size.width  , height: proxy.size.height)
            }
        }
    }
}

struct ContainerRelativeFrameView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0 ..< 10) { i in
                    Text("Item \(i)")
                        .foregroundStyle(.white)
                        .containerRelativeFrame(.horizontal, count: 5, span: 2, spacing: 10)
                        .background(.blue)
                }
            }

            HStack {
                Text("Important")
                    .frame(width: 200)
                    .background(.blue)
                Image(.screenshot20250113At13425PM)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, _ in
                        size * 0.8
                    }
            }
        }
    }
}

#Preview {
    GeometryReaderDemoView()
}
