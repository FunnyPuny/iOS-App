// List+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift

extension List where Element: Comparable {
    func remove(value: Element) {
        for (index, element) in enumerated() where element == value {
            remove(at: index)
        }
    }
}
