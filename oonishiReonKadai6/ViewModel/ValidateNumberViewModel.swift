//
//  ValidateNumberViewModel.swift
//  oonishiReonKadai6
//
//  Created by 大西玲音 on 2021/05/16.
//

import RxCocoa

protocol ValidateNumberViewModelInput {
    func answerSliderValueDidChanged(value: Float)
    func answerButtonDidTapped()
    func retryButtonDidTapped()
}

protocol ValidateNumberViewModelOutput {
    var event: Driver<ValidateNumberViewModel.Event> { get }
    var randomNumberText: Driver<String?> { get }
    var sliderMinimumValue: Driver<Float> { get }
    var sliderMaximumValue: Driver<Float> { get }
}

protocol ValidateNumberViewModelType {
    var inputs: ValidateNumberViewModelInput { get }
    var outputs: ValidateNumberViewModelOutput { get }
}

// ViewModel（ビューモデル）はViewを描画するための状態の保持と、
// Viewから受け取った入力を適切な形に変換してModelに伝達する役目を持つ。
// すなわちViewとModelの間の情報の伝達と、Viewのための状態保持のみを役割とする要素である。
// https://ja.wikipedia.org/wiki/Model_View_ViewModel
final class ValidateNumberViewModel: ValidateNumberViewModelInput,
                                     ValidateNumberViewModelOutput {
    enum Event {
        case correctAlert(String)
        case incorrectAlert(String)
        case changeSliderValue(Float)
    }

    var event: Driver<Event> {
        eventRelay.asDriver(onErrorDriveWith: .empty())
    }
    private let eventRelay = PublishRelay<Event>()

    var randomNumberText: Driver<String?> {
        randomNumberGame.correctAnswer
            .map { String($0) }
            .asDriver(onErrorDriveWith: .empty())
    }
    private let randomNumberTextRelay = BehaviorRelay<String?>(value: "")

    var sliderMinimumValue: Driver<Float> {
        randomNumberGame.min
            .map { Float($0) }
            .asDriver(onErrorDriveWith: .empty())
    }

    var sliderMaximumValue: Driver<Float> {
        randomNumberGame.max
            .map { Float($0) }
            .asDriver(onErrorDriveWith: .empty())
    }

    private let randomNumberGame = RandomNumberGame(min: 1, max: 100)

    private var currentAnswerValue: Float = 0

    func viewDidLoad() {
        eventRelay.accept(.changeSliderValue(50))
        randomNumberTextRelay.accept(String(50))
    }

    func answerSliderValueDidChanged(value: Float) {
        currentAnswerValue = value
        randomNumberTextRelay.accept(String(Int(value)))
    }

    func answerButtonDidTapped() {
        if randomNumberGame.checkAnswer(answer: Int(currentAnswerValue)) {
            eventRelay.accept(.correctAlert(ValidationMessage.correct))
        } else {
            eventRelay.accept(.incorrectAlert(ValidationMessage.incorrect))
        }
    }

    func retryButtonDidTapped() {
        randomNumberGame.resetGame()
        eventRelay.accept(.changeSliderValue(50))
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
