//
//  CodableProtocolView.swift
//  Moonshot
//
//  Created by Xristos Mantsos on 17/9/24.
//

// TODO: Display decoded data on the UI: Instead of printing the decoded user details, display the name and address in a Text view within the SwiftUI interface.

// TODO: Add error handling: Implement proper error handling for the JSON decoding process, and display an alert if the decoding fails.

import SwiftUI

struct User: Codable {
    let name: String
    let address: Address
}

struct Address: Codable {
    let street: String
    let city: String
}

struct CodableProtocolView: View {
    @State private var showAlert = false
    @State private var user: User?
    var body: some View {
        NavigationStack {
            Button("DecodeJSON") {
                let input = """
                {
                    "name" : "Taylor Swift"
                    "address": {
                        "street" : "555, Taylor swift UI",
                        "city" : "Nashvilllew"
                    }
                }
                """
                .data(using: .utf8)!

                //            let data = Data(input.utf8)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: input)
                    print(user.address)
                    self.user = user

                } catch {
                    self.showAlert.toggle()
                }
            }
            .padding(41)

            if let user = user {
                NavigationLink(destination: UserDetailsView(user: user)) {
                    Text("User Details")
                }
            }
        }
        .alert(isPresented: self.$showAlert) {
            Alert(title: Text("No Data to display"), message: Text("Please try again later...."), dismissButton: .cancel())
        }
    }
}

struct UserDetailsView: View {
    let user: User
    var body: some View {
        ZStack {
            ContentView()
            VStack {
                Text("User name : \(self.user.name)")
                    .textModifier()
                Text("Address : \(self.user.address.city)")
                    .textModifier()
            }
        }
    }
}

extension View {
    func textModifier() -> some View {
        self
            .font(.title.bold())
            .padding()
    }
}

#Preview {
    CodableProtocolView()
}
