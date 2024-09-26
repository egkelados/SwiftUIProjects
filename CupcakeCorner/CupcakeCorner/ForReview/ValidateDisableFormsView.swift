//
//  ValidateDisableFormsView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 26/9/24.
//

import SwiftUI

struct ValidateDisableFormsView: View {
    @State private var userName: String = ""
    @State private var email: String = ""

    var disabledForm: Bool {
        return userName.count < 5 || email.count < 5
    }

    var body: some View {
        VStack {
            Form {
                Section {
                    TextField("give me username", text: $userName)
                    TextField("give me email", text: $email)
                }
                Section {
                    Button("Create Account") {
                        print("creating account.....")
                    }
                }
                .disabled(disabledForm)
            }
        }
    }
}

#Preview {
    ValidateDisableFormsView()
}
