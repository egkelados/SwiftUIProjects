//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 3/1/25.
//

import CodeScanner
import SwiftData
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    @Environment(\.modelContext) var context
    @Query var prospects: [Prospects]
    @State private var isShowingScan = false
    @State private var selectedProspects = Set<Prospects>()
    @State private var sortByName = true

    private let contacted = "person.crop.circle.fill.badge.checkmark"
    private let unContacted = "person.crop.circle.badge.xmark"

    enum FilterType {
        case none, contacted, uncontacted
    }

    let filter: FilterType

    var title: String {
        switch filter {
        case .none:
            "Everyone"
        case .contacted:
            "Contacted people"
        case .uncontacted:
            "Uncontacted people"
        }
    }

    var filteredProspects: [Prospects] {
        var prospects = prospects
        if filter == .contacted {
            prospects = prospects.filter { $0.isContacted }
        } else if filter == .uncontacted {
            prospects = prospects.filter { !$0.isContacted }
        }

        if sortByName {
            return prospects.sorted { $0.name < $1.name }
        } else {
            return prospects.sorted { $0.joinDate > $1.joinDate }
        }
    }

    var body: some View {
        NavigationStack {
            List(filteredProspects, selection: $selectedProspects) { prospect in
                NavigationLink(destination: EditProspectView(prospect: prospect)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)

                            Text(prospect.emailAddress)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                        if filter == .none {
                            Label("", systemImage: prospect.isContacted == true ? contacted : unContacted)
                                .foregroundStyle(prospect.isContacted == true ? .green : .red)
                                .accessibilityLabel(prospect.isContacted == true ? "Contacted" : "Uncontacted")
                        }
                    }
                }
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        context.delete(prospect)
                    }

                    if prospect.isContacted {
                        Button("Mark Uncontacted", systemImage: unContacted) {
                            prospect.isContacted.toggle()
                        }
                        .tint(.blue)

                    } else {
                        Button("Mark Contacted", systemImage: contacted) {
                            prospect.isContacted.toggle()
                        }
                        .tint(.green)

                        Button("Remind Me", systemImage: "bell") {
                            addNotification(for: prospect)
                        }
                        .tint(.orange)
                    }
                }
                .tag(prospect)
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Scan", systemImage: "qrcode.viewfinder") {
                        isShowingScan = true
                    }
                }

                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }

                ToolbarItem(placement: .secondaryAction) {
                    Button("Sort by \(sortByName ? "date" : "name")") {
                        sortByName.toggle()
                    }
                }

                if selectedProspects.isEmpty == false {
                    ToolbarItem(placement: .bottomBar) {
                        Button("Delete Selected", action: delete)
                    }
                }
            }
            .sheet(isPresented: $isShowingScan) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Some\nsome@gmail.com", completion: handleScan)
            }
        }
    }

    init(filter: FilterType) {
        self.filter = filter
        _prospects = Query()

        if filter != .none {
            let showContactedOnly = filter == .contacted

            _prospects = Query(filter: #Predicate {
                $0.isContacted == showContactedOnly
            }, sort: [SortDescriptor(\Prospects.name)])
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScan = false

        switch result {
        case .success(let success):
            let details = success.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospects(name: details[0], emailAddress: details[1], isContacted: false, joinDate: .now)
            context.insert(person)
        case .failure(let failure):
            print("Scanning failed: \(failure.localizedDescription)")
        }
    }

    func delete() {
        for prospect in selectedProspects {
            context.delete(prospect)
        }
    }

    func addNotification(for prospect: Prospects) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default

//            var dateComponents = DateComponents()
//            dateComponents.hour = 9
//            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            /// this is for testing only when in production uncomment the above  : triger and dateComponents
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

#Preview {
    ProspectsView(filter: .none)
        .modelContainer(for: Prospects.self)
}
