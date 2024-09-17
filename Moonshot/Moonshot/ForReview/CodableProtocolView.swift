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
    var body: some View {
        Button("DecodeJSON") {
            let input = """
            {
                "name" : "Taylor Swift",
                "address": {
                    "street" : "555, Taylor swift UI",
                    "city" : "Nashvilllew"
                }
            }
            """

            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(User.self, from: data) {
                print(user.address)
            }
        }
    }
}

#Preview {
    CodableProtocolView()
}
