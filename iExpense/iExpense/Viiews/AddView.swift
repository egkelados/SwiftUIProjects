import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss

    @State private var name = "Name of expense"
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var title = "Add new expense"
    var expenses: Expenses

    let types = ["Buiseness", "Personal"]

    var body: some View {
        NavigationStack {
            Form {
//                TextField("Name", text: $name)

                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
//                ToolbarItem(placement: .principal) {
//                    TextField("Expense Name", text: $title)
//                        .textFieldStyle(.plain)
//                        .multilineTextAlignment(.center)
//                }
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(item)
                        dismiss()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
