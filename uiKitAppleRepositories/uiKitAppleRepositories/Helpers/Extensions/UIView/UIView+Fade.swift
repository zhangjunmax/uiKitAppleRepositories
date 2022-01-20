//
//  UIView+Fade.swift
//  uiKitAppleRepositories
//
//  Created by Jun Zhang on 2022/1/20.
//

import Foundation
import UIKit

extension UIView {
    func fadeIn(duration: TimeInterval = 0.3) {
        isHidden = false
        alpha = 0.0
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
}
