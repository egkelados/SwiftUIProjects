//
//  EditProspectView.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 7/1/25.
//
import SwiftData
import SwiftUI

struct EditProspectView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Bindable private var originalProspect: Prospects

    @State private var tempName: String
    @State private var tempEmail: String

    init(prospect: Prospects) {
        originalProspect = prospect
        _tempName = State(initialValue: prospect.name) // refer to the backing store of the @State property
        _tempEmail = State(initialValue: prospect.emailAddress)
    }

    var body: some View {
        Form {
            TextField("Name", text: $tempName)
                .textContentType(.name)

            TextField("Email Address", text: $tempEmail)
                .textContentType(.emailAddress)
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
        }
        .navigationTitle("Edit \(originalProspect.name)")
        .toolbar {
            Button("Save") {
                originalProspect.name = tempName
                originalProspect.emailAddress = tempEmail
                try? context.save()
                dismiss()
            }
        }
    }
}

#Preview {
    do {
        let container = try ModelContainer(for: Prospects.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let example = Prospects(name: "Maik Whine", emailAddress: "maikbold@gmail.com", isContacted: false, joinDate: .now)
        container.mainContext.insert(example)
        return NavigationStack { EditProspectView(prospect: example)
            .modelContainer(container)
        }
    } catch {
        return Text("Failed to create container: \(error.localizedDescription)")
    }
}
