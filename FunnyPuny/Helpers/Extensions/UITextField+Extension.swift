// UITextField+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UITextField {
    func isValid() -> Bool {
        guard let text, !text.isEmptyOrWhitespace() else {
            print("Please fill the field.")
            return false
        }
        return true
    }
}
