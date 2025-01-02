//
//  ResultTypeDemo.swift
//  HotProspects
//
//  Created by Xristos Mantsos on 2/1/25.
//

import SwiftUI

struct ResultTypeDemo: View {
    @State private var output = ""
    var body: some View {
        Text(output)
            .task {
                await fetchReadings()
            }
    }

    func fetchReadings() async {
        let fetchTask = Task {
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }

        let result = await fetchTask.result

        switch result {
        case .success(let success):
            output = success
        case .failure(let failure):
            output = "Error: \(failure.localizedDescription)"
        }
    }
}

#Preview {
    ResultTypeDemo()
}
