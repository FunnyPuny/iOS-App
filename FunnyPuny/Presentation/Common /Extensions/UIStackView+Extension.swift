// UIStackView+Extension.swift
// Created by Zlata Guseva on 16.10.2022.

import UIKit

extension UIStackView {
    func addSubviews(_ subViews: [UIView]) {
        for value in subViews {
            addArrangedSubview(value)
        }
    }
}
