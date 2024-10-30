//
//  GalleryView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 30/10/24.
//

import SwiftUI

struct GalleryView: View {
    let images: [String]
    var body: some View {
        ScrollView {
            VStack {
                ForEach(images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0))
                        .padding()
                }
            }
            .navigationTitle("Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(.darkBackground)
    }
}

#Preview {
    GalleryView(images: [""])
}
