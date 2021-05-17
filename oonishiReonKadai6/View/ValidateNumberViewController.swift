//
//  ValidateNumberViewController.swift
//  oonishiReonKadai6
//
//  Created by 大西玲音 on 2021/05/16.
//

import UIKit
import RxSwift
import RxCocoa

final class ValidateNumberViewController: UIViewController {
    
    @IBOutlet private weak var randomNumberLabel: UILabel!
    @IBOutlet private weak var validateSlider: UISlider!
    
    private var validateNumber = 0
    private var sliderMinValue: Float { validateSlider.minimumValue }
    private var sliderMaxValue: Float { validateSlider.maximumValue }
    private var sliderCenterValue: Float { floor((sliderMinValue + sliderMaxValue) / 2) }
    private var randomNumberText: String { String(Int(Float.random(in: sliderMinValue...sliderMaxValue))) }
    private let validateNumberViewModel = ValidateNumberViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initValidationState()
        setupBindings()
        
    }
    
    private func setupBindings() {
        validateNumberViewModel.outputs.event
            .drive(onNext: { [weak self] event in
                guard let self = self else { return }
                switch event {
                    case .correctAlert(let message):
                        self.showAlert(message: message) { _ in
                            self.initValidationState()
                        }
                    case .incorrectAlert(let message):
                        self.showAlert(message: message)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func initValidationState() {
        randomNumberLabel.text = randomNumberText
        validateSlider.setValue(sliderCenterValue, animated: true)
        validateNumber = Int(sliderCenterValue)
    }
    
    @IBAction private func validateSliderValueDidChanged(_ sender: UISlider) {
        validateNumber = Int(sender.value)
    }
    
    @IBAction private func validateButtonDidTapped(_ sender: Any) {
        guard let randomeNumber = randomNumberLabel.text.flatMap({ Int($0) }) else { return }
        validateNumberViewModel.inputs.validateButtonDidTapped(randomeNumber: randomeNumber,
                                                               validateNumber: validateNumber)
    }
    
}
