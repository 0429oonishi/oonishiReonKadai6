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
        let validationSubMessage = "\nあなたの値: \(validateNumber)"
        switch isCorrect {
            case true:
                let message = ValidationMessage.correct + validationSubMessage
                return .correct(message)
            case false:
                let message = ValidationMessage.incorrect + validationSubMessage
                return .incorrect(message)
        }
    }
}
