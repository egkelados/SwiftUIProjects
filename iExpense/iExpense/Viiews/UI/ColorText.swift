//
//  ColorText.swift
//  iExpense
//
//  Created by Xristos Mantsos on 31/10/24.
//

import SwiftUI

// MARK: - Custom View for amount colors

struct ColorText: View {
    let itemsAmount: Double

    var body: some View {
        if itemsAmount < 10 {
            Text(itemsAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(.green)
        } else if itemsAmount > 10 && itemsAmount < 100 {
            Text(itemsAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(.blue)
        } else {
            Text(itemsAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    ColorText(itemsAmount: 15.5)
}
