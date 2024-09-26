//
//  LoadImageView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 26/9/24.
//

import SwiftUI

struct LoadImageView: View {
    var body: some View {
        // MARK: - 3 ways to load image from url

        /// option: 1
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale: 5)
        
        /// option: 2 using initializer of AsyncImage object
        /*
         AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
             image
                 .resizable()
                 .scaledToFit()
         } placeholder: {
             ProgressView()
         }
         .frame(width: 500,height: 300)
         */
        
        /// option: 3  using initializer of AsyncImage object, working with the AsyncImagePhase enumeration which gives more control over the different phases of image loading: Error phase, Success phase
        
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil {
                Text("There was an error loading the image!")
            } else {
                ProgressView()
            }
        }
        .frame(width: 200,height: 200)
    }
}

#Preview {
    LoadImageView()
}
