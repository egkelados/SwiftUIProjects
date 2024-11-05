//
//  ActualAppView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 27/9/24.
//

import SwiftUI

// MARK: - Users list

struct UsersListView: View {
    let order: Order
    var body: some View {
        List(order.users) { user in
            Text("\(user.name)")
        }
    }
}

struct ActualAppView: View {
    @State private var order = Order()

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Choose your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    .pickerStyle(.segmented)

                    Stepper("Number of cakes: \(order.quantity)", value: $order.quantity, in: 3 ... 20)
                }
                Section {
                    Toggle("Special Request", isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled {
                        Toggle("Add springles", isOn: $order.addSprinkles)
                        Toggle("Extra frosting", isOn: $order.extraFrosting)
                    }
                }
                Section {
                    NavigationLink("Delivery details", destination: AdressView(order: order))
                }
            }
            .navigationTitle("Cupcake Corner")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink("Users") {
                        UsersListView(order: order)
                    }
                }
            }
        }
    }
}

#Preview {
    ActualAppView()
}
