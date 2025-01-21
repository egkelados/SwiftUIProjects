//
//  ActualAppView.swift
//  SnowSeeker
//
//  Created by Xristos Mantsos on 15/1/25.
//

import SwiftUI

extension ActualAppView {
    enum SortResort: String, CaseIterable, Identifiable {
        case defaultOrder = "Default"
        case alphabetical = "Alphabetical"
        case country = "Country"

        var id: String { rawValue }
    }

    @Observable
    class ActualAppViewModel {
        var searchText = ""
        var sortBy: SortResort = .defaultOrder
        var resorts: [Resort]

        init() {
            resorts = Bundle.main.decode("resorts.json")
        }

        var filteredResort: [Resort] {
            var filtered = searchText.isEmpty
                ? resorts
                : resorts.filter { resort in
                    resort.name.localizedStandardContains(searchText)
                }

            switch sortBy {
            case .defaultOrder:
                break
            case .alphabetical:
                filtered.sort { $0.name < $1.name }
            case .country:
                filtered.sort { $0.country < $1.country }
            }

            return filtered
        }
    }
}

struct ActualAppView: View {
    @State private var favorites = Favorites()
    @Bindable var vm = ActualAppViewModel()
    let resorts: [Resort] = Bundle.main.decode("resorts.json")

    var body: some View {
        NavigationSplitView {
            VStack {
                Picker("Sort by:", selection: $vm.sortBy) {
                    ForEach(SortResort.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                List(vm.filteredResort) { res in
                    NavigationLink(value: res) {
                        ExtractedView(res: res, isFavorites: favorites.contains(res))
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $vm.searchText, prompt: "Search for a resort")
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
    }
}

#Preview {
    ActualAppView()
}

struct ExtractedView: View {
    let res: Resort
    let isFavorites: Bool

    var body: some View {
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

            if isFavorites {
                Spacer()
                Image(systemName: "heart.fill")
                    .accessibilityLabel("This is a favorite resort")
                    .foregroundStyle(.red)
            }
        }
    }
}
