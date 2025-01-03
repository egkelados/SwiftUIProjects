//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 3/1/25.
//

import CodeScanner
import SwiftData
import SwiftUI

struct ProspectsView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Prospects.name) var prospects: [Prospects]
    @State private var isShowingScan = false
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

    var body: some View {
        NavigationStack {
            List(prospects) { prospect in
                VStack(alignment: .leading) {
                    Text(prospect.name)
                        .font(.headline)

                    Text(prospect.emailAddress)
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle(title)
            .toolbar {
                Button("Scan", systemImage: "qrcode.viewfinder") {
                    isShowingScan = true
                }
            }
            .sheet(isPresented: $isShowingScan){
                CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Some\nsome@gmail.com", completion: handleScan)
            }
        }
    }

    init(filter: FilterType) {
        self.filter = filter

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
            
            let person = Prospects(name: details[0], emailAddress: details[1], isContacted: false)
            context.insert(person)
        case .failure(let failure):
            print("Scanning failed: \(failure.localizedDescription)")
        }
        
    }
}

#Preview {
    ProspectsView(filter: .contacted)
        .modelContainer(for: Prospects.self)
}
