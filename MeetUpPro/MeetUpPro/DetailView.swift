//
//  DetailView.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 29/12/24.
//

import SwiftUI

struct DetailView: View {
    let img: DataMeet

    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                if let uiImage = UIImage(data: img.image) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                }

                Text(img.name)
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -7, y: -10)
            }
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

// #Preview {
//    DetailView(img: DataMeet)
// }
