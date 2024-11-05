//
//  AdressView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 27/9/24.
//

import SwiftUI

// MARK: - custom modifier for trimming

struct trimmedField: ViewModifier {
    @Binding var text: String
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { newValue, _ in
                text = newValue.trimmedString
            }
    }
}

extension View {
    func trimmedText(_ text: Binding<String>) -> some View {
        modifier(trimmedField(text: text))
    }
}

// MARK: - Address View

struct AdressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)

                TextField("Street", text: $order.streetAddress)

                TextField("City", text: $order.city)

                TextField("Zip", text: $order.zip)
            }

            Section {
                NavigationLink("Check out") {
                    CheckoutView(order: order)
                }
            }
            .disabled(order.isValid == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AdressView(order: Order())
}
