//
//  ValidateNumber.swift
//  oonishiReonKadai6
//
//  Created by 大西玲音 on 2021/05/16.
//

import Foundation

enum ValidationMessage {
    static let correct = "あたり！"
    static let incorrect = "ハズレ！"
}

enum ValidationResult<Correct, Incorrect> {
    case correct(Correct)
    case incorrect(Incorrect)
}

struct ValidateNumber {
    func validate(randomeNumber: Int, validateNumber: Int) -> ValidationResult<String, String> {
        let isCorrect = (randomeNumber == validateNumber)
        if isCorrect {
            let message = "\(ValidationMessage.correct)\nあなたの値: \(validateNumber)"
            return .correct(message)
        }
        let message = "\(ValidationMessage.incorrect)\nあなたの値: \(validateNumber)"
        return .incorrect(message)
    }
}
