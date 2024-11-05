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

//MARK: - Address View

struct AdressView: View {
    @Bindable var order: Order

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                    .trimmedText($order.name)
                TextField("Street", text: $order.streetAddress)
                    .trimmedText($order.streetAddress)
                TextField("City", text: $order.city)
                    .trimmedText($order.city)
                TextField("Zip", text: $order.zip)
                    .trimmedText($order.zip)
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
