import SwiftUI

struct QuestionsView: View {
    let questions: [Question]
    @Environment(\.dismiss) var dismiss
    @State private var number = 0
    @State private var answer: String = ""
    @State private var alertAnswer = false
    @FocusState private var nameIsFocused: Bool

    var body: some View {
        NavigationStack {
            VStack {
                if number < questions.count {
                    Text(questions[number].question)
                        .font(.title.bold())
                    
                    TextField("", text: $answer)
                        .frame(width: (UIScreen.current?.bounds.width ?? 300) / 2.2, height: 50)
                        .background(.gray.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .font(.title)
                        .padding()
                        .keyboardType(.decimalPad)
                        .focused($nameIsFocused)

                    Button("Submit") {
                        if let answer = Int(answer), answer == questions[number].answer {
                            if number < questions.count - 1 {
                                number += 1
                                self.answer = ""
                            } else {
                                
                                dismiss()
                            }
                        } else {
                            alertAnswer = true
                        }
                        nameIsFocused.toggle()
                    }
                    .padding(10)
                    .foregroundStyle(.black)
                    .background(.gray.opacity(0.7))
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                }
            }
            .alert("Wrong answer!", isPresented: $alertAnswer) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text("🐹You can do it!🐶")
            }
            .navigationTitle("Quiz Time")
        }
    }
}

#Preview {
    NavigationStack {
        QuestionsView(questions: [
            Question(question: "What is 2 x 2?", answer: 4),
            Question(question: "What is 3 x 3?", answer: 9)
        ])
    }
}
