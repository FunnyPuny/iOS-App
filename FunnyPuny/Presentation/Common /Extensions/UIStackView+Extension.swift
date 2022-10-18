// UIStackView+Extension.swift
// Created by Zlata Guseva on 16.10.2022.

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        for value in subviews {
            addArrangedSubview(value)
        }
    }
}
