// List+Extension.swift
// Created by Zlata Guseva on 28.10.2022.

import Foundation
import RealmSwift

extension List where Element: Comparable {
    func remove(value: Element) {
        for (index, element) in enumerated() where element == value {
            remove(at: index)
        }
    }
}
