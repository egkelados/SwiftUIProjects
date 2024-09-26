//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Xristos Mantsos on 26/9/24.
//

import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()

    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
    }

    // MARK: - 3 steps to complete :

    func loadData() async {
        /// 1. Creating the URL we want to Read
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL!")
            return
        }

        /// 2. Fetching the data from that URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            /// 3. Decoding the result of that data into a Response struct
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data!")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
