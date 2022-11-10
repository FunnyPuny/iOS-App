// TextField.swift
// FunnyPuny. Created by Zlata Guseva.

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
