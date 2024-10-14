import SwiftUI

struct Question: Hashable {
    let question: String
    let answer: Int
}

struct ContentView: View {
    @State private var questionsNumber: Int = 1
    @State private var baseNumber: Int = 2
    @State private var startPressed = false

    @State private var vm: QuestionVM = .init()
    var body: some View {
        NavigationStack {
            List {
                Text("Choose your desired math practice!")
                    .font(.title2.bold())
                    .padding(25)

                Text("How many questions do you want:")

                Picker("Questions", selection: $questionsNumber) {
                    ForEach(0 ..< 20) { i in
                        Text("\(i)")
                    }
                }
                .pickerStyle(.menu)

                Section {
                    Text("What number to practice:")
                    Stepper("number \(baseNumber)", value: $baseNumber,in: 1...11)
                    Picker("Number", selection: $baseNumber) {
                        ForEach(0 ..< 11) { i in
                            Text("\(i)")
                        }
                    }
                }
            }
            .navigationTitle("Math Practice")
            .navigationDestination(isPresented: $startPressed) {
                QuestionsView(questions: vm.questions)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Settings", systemImage: "gearshape") {}
                }
            }

            Button("Start") {
                vm.generateQuestions(questionsNumber: questionsNumber, baseNumber: baseNumber)
                startPressed = true
            }
        }
    }
}

#Preview {
    ContentView()
}
