//
//  RandomNumberGame.swift
//  oonishiReonKadai6
//
//  Created by akio0911 on 2021/05/18.
//

import RxSwift
import RxRelay

class RandomNumberGame {
    var correctAnswer: Observable<Int> {
        correctAnswerRelay.asObservable()
    }
    private let correctAnswerRelay: BehaviorRelay<Int>

    var min: Observable<Int> {
        minRelay.asObservable()
    }
    private let minRelay: BehaviorRelay<Int>

    var max: Observable<Int> {
        maxRelay.asObservable()
    }
    private let maxRelay: BehaviorRelay<Int>

    init(min: Int, max: Int) {
        self.minRelay = .init(value: min)
        self.maxRelay = .init(value: max)
        correctAnswerRelay = BehaviorRelay<Int>(
            value: RandomNumberGenerator().generate(min: min, max: max)
        )
    }

    func checkAnswer(answer: Int) -> Bool {
        correctAnswerRelay.value == answer
    }

    func resetGame() {
        correctAnswerRelay.accept(
            RandomNumberGenerator().generate(
                min: minRelay.value,
                max: maxRelay.value
            )
        )
    }
}

private struct RandomNumberGenerator {
    func generate(min: Int, max: Int) -> Int {
        Int.random(in: min...max)
    }
}
