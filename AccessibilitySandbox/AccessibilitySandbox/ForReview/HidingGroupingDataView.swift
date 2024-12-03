//
//  HidingGroupingDataView.swift
//  AccessibilitySandbox
//
//  Created by Xristos Mantsos on 3/12/24.
//

import SwiftUI

struct HidingGroupingDataView: View {
    var body: some View {
        VStack {
            Text("Your score is")

            Text("1000")
                .font(.title)
        }
        .accessibilityElement(children: .ignore) // .ignore is the default value..
        .accessibilityLabel("Your score is 1000")
    }
}

#Preview {
    HidingGroupingDataView()
}
