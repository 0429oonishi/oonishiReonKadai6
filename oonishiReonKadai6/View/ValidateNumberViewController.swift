//
//  ValidateNumberViewController.swift
//  oonishiReonKadai6
//
//  Created by 大西玲音 on 2021/05/16.
//

import UIKit
import RxSwift
import RxCocoa

/*
 Viewはアプリケーションの扱うデータをユーザーが見るのに適した形で表示し、
 ユーザーからの入力を受け取る要素である。
 すなわちユーザインタフェースの入出力が責務である。　
 Viewは宣言的に定義され、渡された値に基づいて描画をおこない、
 ユーザー入力を通知する。よってMVVMにおけるViewは状態を持たない。
 https://ja.wikipedia.org/wiki/Model_View_ViewModel
 */

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
        
        // viewModelの状態をただそのままViewに反映
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
    
    @IBAction private func answerSliderValueDidChangted(_ sender: UISlider) {
        validateNumberViewModel.answerSliderValueDidChangted(value: validateSlider.value)
    }
    
    @IBAction private func answerButtonDidTapped(_ sender: Any) {
        validateNumberViewModel.answerButtonDidTapped()
    }
    
}
