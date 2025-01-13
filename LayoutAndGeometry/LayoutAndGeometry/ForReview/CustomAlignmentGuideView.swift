//
//  CustomAlignmentGuideView.swift
//  LayoutAndGeometry
//
//  Created by Xristos Mantsos on 13/1/25.
//

import SwiftUI

extension VerticalAlignment {
    enum MidAccountAndName: AlignmentID {
        static func defaultValue(in context: ViewDimensions) -> CGFloat {
            context[.top]
        }
    }

    static let midAccountAndName = VerticalAlignment(MidAccountAndName.self)
}

struct CustomAlignmentGuideView: View {
    var body: some View {
        HStack(alignment: .midAccountAndName) {
            VStack {
                Text("@egkelados")
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }

                Image(.screenshot20250113At13425PM)
                    .resizable()
                    .frame(width: 64, height: 64)
            }
            VStack {
                Text("Full Name: ")
                Text("ANTON MARVEL")
                    .font(.largeTitle)
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
            }
            VStack {
                Text("Works as: ")
                Text("Actor")
                    .font(.largeTitle)
                    .alignmentGuide(.midAccountAndName) { d in
                        d[VerticalAlignment.center]
                    }
            }
        }
    }
}

#Preview {
    CustomAlignmentGuideView()
}
