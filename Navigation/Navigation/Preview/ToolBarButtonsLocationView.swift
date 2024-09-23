//
//  ToolBarButtonsLocationView.swift
//  Navigation
//
//  Created by Xristos Mantsos on 23/9/24.
//



import SwiftUI

struct ToolBarButtonsLocationView: View {
    var body: some View {
        NavigationStack {
            Text("Hello Mate!")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Tap Me") {
                            // button action code
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Button("Tap Me principal ") {
                            // button action code
                        }
                    }

                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Tap Me trailing") {
                            // button action code
                        }
                    }

                    ToolbarItem(placement: .bottomBar) {
                        Button("Tap Me bottom") {
                            // button action code
                        }
                    }
                }
                .navigationBarBackButtonHidden()
        }
    }
}

#Preview {
    ToolBarButtonsLocationView()
}
