//
//  ValidateNumber.swift
//  oonishiReonKadai6
//
//  Created by 大西玲音 on 2021/05/16.
//

import Foundation

enum ValidationResult {
    case correct
    case incorrect

    init(isCorrect: Bool) {
        self = isCorrect ? .correct : .incorrect
    }
}

struct ValidateNumber {
    func validate(randomeNumber: Int, validateNumber: Int) -> ValidationResult {
        let isCorrect = (randomeNumber == validateNumber)
        return ValidationResult(isCorrect: isCorrect)
    }
}
