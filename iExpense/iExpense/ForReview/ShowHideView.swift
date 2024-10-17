//
//  ShowHideView.swift
//  iExpense
//
//  Created by Xristos Mantsos on 13/9/24.
//

import SwiftUI

struct SecondView: View {
    @Environment(\.dismiss) var dismiss
    let name: String
    
    var body: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            VStack(alignment:  .center, spacing: 50) {
                Text("Hello \(name)")
                    .font(.system(size: 25))
                Divider()
                Button("Dismiss") {
                    dismiss()
                }
                .padding(5)
                .font(.system(size: 25).bold())
//                .frame(width:155, height: 125)
                .background(.gray)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            }
            .padding()
        }
    }
}

struct ShowHideView: View {
    @State private var showingSheet = false
    
    var body: some View {
        Button("Show sheet") {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, content: {
            SecondView(name: "Boy")
        })
    }
}

#Preview {
    ShowHideView()
}
