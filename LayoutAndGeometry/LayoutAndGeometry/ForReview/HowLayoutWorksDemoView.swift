//
//  HowLayoutWorksDemoView.swift
//  LayoutAndGeometry
//
//  Created by Xristos Mantsos on 13/1/25.
//

import SwiftUI

struct HowLayoutWorksDemoView: View {
    var body: some View {
        VStack(alignment: .leading){
            ForEach(0..<10) { position in
                    Text("Number \(position)")
                    .alignmentGuide(.leading) { _ in
                            Double(position) * -10
                    }
            }
        }
        .background(.red)
        .frame(width: 400, height: 400)
        .background(.blue)
            
    }
}

#Preview {
    HowLayoutWorksDemoView()
}
