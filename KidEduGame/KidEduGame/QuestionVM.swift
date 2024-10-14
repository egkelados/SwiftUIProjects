//
//  QuestionVM.swift
//  KidEduGame
//
//  Created by Xristos Mantsos on 9/10/24.
//

import Foundation
import Observation

@Observable
class QuestionVM {
    var questions: [Question] = []

    func generateQuestions(questionsNumber: Int, baseNumber: Int) {
        questions.removeAll()
        for _ in 1 ... questionsNumber {
            let randomnumber = Int.random(in: 0 ..< (baseNumber + 1))
            let question = "What is \(randomnumber) x \(baseNumber): "
            let answer = randomnumber * baseNumber
            let questionData = Question(question: question, answer: answer)
            questions.append(questionData)
        }
    }
}
