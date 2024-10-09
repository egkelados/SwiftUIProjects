import SwiftUI

struct Show: ViewModifier {
    let duration: Duration
    @Binding var isVisible: Bool
    @State private var initial: Bool = true

    func body(content: Content) -> some View {
        content
            .opacity(isVisible ? 1 : 0)
            .task(id: isVisible) {
                if initial {
                    initial = false
                    return
                }

                try? await Task.sleep(for: duration)
                guard !Task.isCancelled else { return }
                withAnimation {
                    isVisible = false
                }
            }
    }
}

extension View {
    func show(duration: Duration, isVisible: Binding<Bool>) -> some View {
        modifier(Show(duration: duration, isVisible: isVisible))
    }
}

struct ContentView: View {
    @State private var isVisible = false

    var body: some View {
        VStack {
            Button("Show") {
                isVisible = true
            }
            Circle()
                .frame(width: 100,height: 100)
                .padding()
                .show(duration: .seconds(2.0), isVisible: $isVisible)
            
            Text("Data has been saved.")
                .font(.callout.bold())
                .padding()
                .background(.green)
                .clipShape(RoundedRectangle(cornerRadius: 35))
                .show(duration: .seconds(1.0), isVisible: $isVisible)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
