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
    
    private let validateNumberViewModel = ValidateNumberViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        validateNumberViewModel.viewDidLoad()
    }
    
    private func setupBindings() {
        validateNumberViewModel.outputs.event
            .drive(onNext: { [weak self] event in
                guard let strongSelf = self else { return }
                switch event {
                    case .correctAlert(let message), .incorrectAlert(let message):
                        strongSelf.showAlert(message: message) { [weak self] _ in
                            self?.validateNumberViewModel.retryButtonDidTapped()
                        }
                    case .changeSliderValue(let value):
                        strongSelf.validateSlider.value = value
                }
            })
            .disposed(by: disposeBag)

        validateNumberViewModel.outputs.randomNumberText
            .drive(randomNumberLabel.rx.text)
            .disposed(by: disposeBag)

        validateNumberViewModel.outputs.sliderMinimumValue
            .drive(validateSlider.rx.minimumValue)
            .disposed(by: disposeBag)

        validateNumberViewModel.outputs.sliderMaximumValue
            .drive(validateSlider.rx.maximumValue)
            .disposed(by: disposeBag)
    }
    
    @IBAction private func validateSliderValueDidChanged(_ sender: UISlider) {
        // ViewModelに丸投げ
        validateNumberViewModel.answerSliderValueDidChanged(value: validateSlider.value)
    }
    
    @IBAction private func validateButtonDidTapped(_ sender: Any) {
        // ViewModelに丸投げ
        validateNumberViewModel.answerButtonDidTapped()
    }
}
