//
//  ActualAppView.swift
//  SnowSeeker
//
//  Created by Xristos Mantsos on 15/1/25.
//

import SwiftUI

struct ActualAppView: View {
    @State private var searchText = ""
    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    var filteredResort: [Resort] {
        if searchText.isEmpty {
            resorts
        }
        else {
            resorts.filter { resort in

                resort.name.localizedStandardContains(searchText)
            }
        }
    }

    var body: some View {
        NavigationSplitView {
            List(filteredResort) { res in
                NavigationLink(value: res) {
                    HStack {
                        Image(res.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 6)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(res.name)
                                .font(.headline)
                            Text("\(res.runs)")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
        } detail: {
            WelcomeView()
        }
    }
}

#Preview {
    ActualAppView()
}
