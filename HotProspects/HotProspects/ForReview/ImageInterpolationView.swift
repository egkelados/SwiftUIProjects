//
//  ImageInterpolationView.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 2/1/25.
//

import SwiftUI

struct ImageInterpolationView: View {
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            Image(.example)
                .interpolation(.none)
                .resizable()
                .scaledToFit()
        }
    }
}

#Preview {
    ImageInterpolationView()
}
