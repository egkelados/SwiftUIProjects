//
//  CustomAlertView.swift
//  MeetUpPro
//
//  Created by Xristos Mantsos on 2/1/25.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var isPresented: Bool
    @Binding var inputName: String
    let title: String
    let message: String
    let actionTitle: String
    let cancelTitle: String
    let action: () -> Void
    let cancelAction: () -> Void

    var body: some View {
        if isPresented {
            ZStack {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()

                VStack(spacing: 0) {
                    Text(title)
                        .font(.headline)
                        .padding(.top)

                    Text(message)
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)

                    TextField("Enter name", text: $inputName)
                        .textFieldStyle(.roundedBorder)
                        .padding(.horizontal)
                        .padding([.bottom, .top], 8)
                        .keyboardType(.default)

                    Divider()

                    HStack(spacing: 0) {
                        Button(cancelTitle) {
                            cancelAction()
                            isPresented = false
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)

                        Divider()
                            .frame(width: 1, height: 44)
                            .background(Color(UIColor.separator))

                        Button(actionTitle) {
                            action()
                            isPresented = false
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.blue)
                        .disabled(inputName.isEmpty)
                    }
                }
                .frame(width: 280)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(14)
                .shadow(radius: 20)
                .transition(.opacity.animation(.easeInOut))
            }
        }
    }
}

struct CustomAlertView_Preview: View {
    @State private var isPresented = true
    @State private var inputName = ""

    var body: some View {
        ZStack {
            Color.gray.opacity(0.3)
                .ignoresSafeArea()

            CustomAlertView(
                isPresented: $isPresented,
                inputName: $inputName,
                title: "Photo Title",
                message: "Enter a name for the photo.",
                actionTitle: "Save",
                cancelTitle: "Cancel"
            ) {
                inputName = ""
            } cancelAction: {
                inputName = ""
            }
        }
    }
}

struct CustomAlertView_Preview_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CustomAlertView_Preview()
                .preferredColorScheme(.light)

            CustomAlertView_Preview()
                .preferredColorScheme(.dark)
        }
    }
}
