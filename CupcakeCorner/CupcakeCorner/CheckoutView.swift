//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 30/9/24.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorSubmittingForm = false
    @State private var errorMessage = ""

    var order: Order

    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error uploading the photo!")
                    } else {
                        ProgressView()
                    }
                }
                .frame(height: 230)

                Text("Your total cost is \(order.cost, format: .currency(code: "EUR"))")
                    .font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/ .bold())

                Button("Submit") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confirmationMessage)
        }
        .alert("Internet Error", isPresented: $errorSubmittingForm) {
            Button("Ok") {}
        } message: {
            Text(errorMessage)
        }
    }

    func placeOrder() async {
        let encoder = JSONEncoder()

        // encode the data / order
        guard let encoded = try? encoder.encode(order) else {
            print("Failed to encode order")
            return
        }

        // create url / config request
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        // decode the data add confirmation message to the user
        do {
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)

            // add user into the userDefaults
            let newUser = UserInfos(name: order.name, streetAddress: order.streetAddress, city: order.city, zip: order.zip)
            order.users.append(newUser)

            confirmationMessage = "Your order for \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
            showingConfirmation = true

        } catch {
            errorSubmittingForm.toggle()
            errorMessage = "Unable to reach the server...Try again later... :)"
        }
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
