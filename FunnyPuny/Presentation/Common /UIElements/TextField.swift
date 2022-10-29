// TextField.swift
// Created by Zlata Guseva on 29.10.2022.

import UIKit
class TextField: UITextField {
    let inset: CGFloat = 16

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: inset, dy: 0)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: inset, dy: 0)
    }
}
