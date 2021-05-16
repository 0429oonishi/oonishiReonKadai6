//
//  ValidateNumberViewController.swift
//  oonishiReonKadai6
//
//  Created by 大西玲音 on 2021/05/16.
//

import UIKit

final class ValidateNumberViewController: UIViewController {
    
    @IBOutlet private weak var randomNumberLabel: UILabel!
    @IBOutlet private weak var validateSlider: UISlider!
    
    private var validateNumber = Int()
    private var sliderMinValue: Float { validateSlider.minimumValue }
    private var sliderMaxValue: Float { validateSlider.maximumValue }
    private var sliderCenterValue: Float { floor((sliderMinValue + sliderMaxValue) / 2) }
    private var randomNumberText: String { String(Int(Float.random(in: sliderMinValue...sliderMaxValue))) }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomNumberLabel.text = randomNumberText
        validateSlider.setValue(sliderCenterValue, animated: true)
        validateNumber = Int(sliderCenterValue)
        
    }
    
    @IBAction private func validateSliderValueDidChanged(_ sender: UISlider) {
        validateNumber = Int(sender.value)
    }
    
    @IBAction private func validateButtonDidTapped(_ sender: Any) {
        guard let randomeNumber = randomNumberLabel.text.flatMap({ Int($0) }) else { return }
        let isCorrect = randomeNumber == validateNumber
        let validationState: ValidationState = isCorrect ? .correct : .incorrect
        let message = "\(validationState.text)\nあなたの値: \(validateNumber)"
        showAlert(message: message) { _ in
            if isCorrect {
                self.randomNumberLabel.text = self.randomNumberText
                self.validateSlider.setValue(self.sliderCenterValue, animated: true)
            }
        }
    }
    
}

private enum ValidationState {
    case correct
    case incorrect
    var text: String {
        switch self {
            case .correct: return "あたり！"
            case .incorrect: return "ハズレ！"
        }
    }
}
