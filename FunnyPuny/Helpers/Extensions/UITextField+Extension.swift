// UITextField+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UITextField {
    func isValid(with word: String) -> Bool {
        guard let text,
              !text.isEmpty, !text.contains(word)
        else {
            print("Please fill the field.")
            return false
        }
        return true
    }
}
