//
//  NavToGalleryView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 30/10/24.
//

import SwiftUI

struct NavToGalleryView: View {
    var body: some View {
        Text("Gallery of Mission")
            .foregroundStyle(.white)
            .font(.title.bold())
            .padding()

        NavigationLink(destination: GalleryView()) {
            Text("View Photos")
                .font(.headline)
                .foregroundColor(.blue)
                .padding()
                .background(.lightBackground)
                .clipShape(.rect(cornerRadius: 15))
        }
    }
}

#Preview {
    NavToGalleryView()
}
