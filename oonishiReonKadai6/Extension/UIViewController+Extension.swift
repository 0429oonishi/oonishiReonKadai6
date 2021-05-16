//
//  UIViewController+Extension.swift
//  oonishiReonKadai6
//
//  Created by 大西玲音 on 2021/05/16.
//

import UIKit

extension UIViewController {
    func showAlert(message: String? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: "結果", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "再挑戦", style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
}
