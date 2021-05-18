//
//  RandomNumberGame.swift
//  oonishiReonKadai6
//
//  Created by akio0911 on 2021/05/18.
//

import RxSwift
import RxRelay

class RandomNumberGame {
    let min: Int
    let max: Int

    var correctAnswer: Observable<Int> {
        correctAnswerRelay.asObservable()
    }
    private let correctAnswerRelay: BehaviorRelay<Int>

    init(min: Int, max: Int) {
        self.min = min
        self.max = max
        correctAnswerRelay = BehaviorRelay<Int>(
            value: RandomNumberGenerator().generate(min: min, max: max)
        )
    }

    func checkAnswer(answer: Int) -> Bool {
        correctAnswerRelay.value == answer
    }

    func resetGame() {
        correctAnswerRelay.accept(
            RandomNumberGenerator().generate(min: min, max: max)
        )
    }
}

private struct RandomNumberGenerator {
    func generate(min: Int, max: Int) -> Int {
        Int.random(in: min...max)
    }
}
