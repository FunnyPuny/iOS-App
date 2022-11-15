// UIStackView+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        for value in subviews {
            addArrangedSubview(value)
        }
    }

    func addSeparators(at positions: [Int], color: UIColor) {
        for position in positions {
            let separator = UIView()
            separator.backgroundColor = color

            insertArrangedSubview(separator, at: position)
            switch axis {
            case .horizontal:
                separator.widthAnchor.constraint(equalToConstant: 1).isActive = true
                separator.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
            case .vertical:
                separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
                separator.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
            @unknown default:
                fatalError("Unknown UIStackView axis value.")
            }
        }
    }
}
