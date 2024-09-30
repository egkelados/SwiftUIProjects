//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 30/9/24.
//

import SwiftUI

struct CheckoutView: View {
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

                Button("Submit", action: {})
                    .padding()
            }
            
        }
        .navigationTitle("Checkout")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        
    }
}

#Preview {
    NavigationStack {
        CheckoutView(order: Order())
    }
}
