//
//  ValidateNumberViewModel.swift
//  oonishiReonKadai6
//
//  Created by 大西玲音 on 2021/05/16.
//

import RxCocoa

protocol ValidateNumberViewModelInput {
    func validateButtonDidTapped(randomeNumber: Int, validateNumber: Int)
}

protocol ValidateNumberViewModelOutput {
    var event: Driver<ValidateNumberViewModel.Event> { get }
}

protocol ValidateNumberViewModelType {
    var inputs: ValidateNumberViewModelInput { get }
    var outputs: ValidateNumberViewModelOutput { get }
}

final class ValidateNumberViewModel: ValidateNumberViewModelInput,
                                     ValidateNumberViewModelOutput {
    enum Event {
        case correctAlert(String)
        case incorrectAlert(String)
    }
    let event: Driver<Event>
    private let eventRelay = PublishRelay<Event>()
    init() {
        self.event = eventRelay.asDriver(onErrorDriveWith: .empty())
    }
    func validateButtonDidTapped(randomeNumber: Int, validateNumber: Int) {
        let result = ValidateNumber().validate(randomeNumber: randomeNumber,
                                               validateNumber: validateNumber)

        let message = result.message

        switch result {
            case .correct:
                eventRelay.accept(.correctAlert(message))
            case .incorrect:
                eventRelay.accept(.incorrectAlert(message))
        }
    }
}

extension ValidateNumberViewModel: ValidateNumberViewModelType {
    var inputs: ValidateNumberViewModelInput {
        return self
    }
    var outputs: ValidateNumberViewModelOutput {
        return self
    }
}

private enum ValidationMessage {
    static let correct = "あたり！"
    static let incorrect = "ハズレ！"
}

private extension ValidationResult {
    var message: String {
        switch self {
        case .correct:
            return ValidationMessage.correct
        case .incorrect:
            return ValidationMessage.incorrect
        }
    }
}
