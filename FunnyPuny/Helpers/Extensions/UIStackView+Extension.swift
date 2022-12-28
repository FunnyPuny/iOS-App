// UIStackView+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        for value in subviews {
            addArrangedSubview(value)
        }
    }
}
