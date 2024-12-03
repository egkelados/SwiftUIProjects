//
//  InputVoiceView.swift
//  AccessibilitySandbox
//
//  Created by Xristos Mantsos on 3/12/24.
//

import SwiftUI

struct InputVoiceView: View {
    var body: some View {
        Button("John Markos Sparrow") {
            print("Button tapped")
        }
        .accessibilityInputLabels(["Markos", "Sparrow", "Johnny Depp", "Pirates"])
    }
}

#Preview {
    InputVoiceView()
}
