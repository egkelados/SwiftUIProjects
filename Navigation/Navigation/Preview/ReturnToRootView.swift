import SwiftUI

@Observable
class PathStore {
    var path: NavigationPath {
//    var path: [Int] {
        didSet {
            save()
        }
    }

    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")

    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
//            if let decoded = try? JSONDecoder().decode([Int].self, from: data) {
                path = NavigationPath(decoded)
//                path = decoded
                return
            }
        }
        path = NavigationPath()
//        path = []
    }

    func save() {
        guard let represantation = path.codable else { return }

        do {
            let data = try JSONEncoder().encode(represantation)
//            let data = try JSONEncoder().encode(path)
            try data.write(to: savePath)
        } catch {
            fatalError("Failed to save navigation data")
        }
    }
}

struct DetailView: View {
    var number: Int

    @Binding var path: NavigationPath
//    @Binding var path: [Int]

    var body: some View {
        NavigationLink("Go th Random Number", value: Int.random(in: 1 ... 1000))
            .navigationTitle("Number: \(number)")
            .toolbar {
                Button("Home") {
//                    path.removeAll()
                    path = NavigationPath()
                }
            }
    }
}

struct ReturnToRootView: View {
    @State private var pathStore = PathStore()
    @State private var path = NavigationPath()
//    @State private var path = [Int]()

    var body: some View {
        NavigationStack(path: $pathStore.path) {
//        NavigationStack(path: $path) {
            DetailView(number: 0, path: $pathStore.path)
                .navigationDestination(for: Int.self) { selection in
                    DetailView(number: selection, path: $pathStore.path)
                }
        }
    }
}

#Preview {
    ReturnToRootView()
}
