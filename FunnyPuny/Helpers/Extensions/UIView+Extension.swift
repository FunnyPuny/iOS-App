// UIView+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
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
