// UIView+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UIView {
    func dropShadow() {
        layer.shadowColor = UIColor.inputShadow?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 3.0
        layer.masksToBounds = false
    }

    func removeShadow() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = .zero
        layer.shadowOffset = .zero
        layer.shadowRadius = .zero
    }

    func fadeIn(
        duration: TimeInterval = 1.0,
        delay: TimeInterval = 0.0,
        completion: @escaping ((Bool) -> Void) = { (_: Bool) in }
    ) {
        alpha = 0.0
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveEaseIn,
            animations: {
                self.isHidden = false
                self.alpha = 1.0
            },
            completion: completion
        )
    }
}
