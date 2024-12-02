//
//  TouchingFaceIdView.swift
//  BucketList
//
//  Created by Xristos Mantsos on 2/12/24.
//

import LocalAuthentication
import SwiftUI

struct TouchingFaceIdView: View {
    
    @State private var isUnlocked = false
    
    var body: some View {
        VStack {
            if isUnlocked {
                Text("Unlocked")
            }else {
                Text("Locked")
            }
            
            Button("Unlock") {
                authenticate()
            }
        }
        .onAppear(perform: authenticate)
    }

    func authenticate() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock your data"

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                if success {
                    isUnlocked = true
                }else {
                    
                }
            }
        }else {
            //no biometrics
        }
    }
}

#Preview {
    TouchingFaceIdView()
}
