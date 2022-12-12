// String+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation

extension String {
    var length: Int {
        count
    }

    subscript(index: Int) -> String {
        self[index ..< index + 1]
    }

    func substring(fromIndex: Int) -> String {
        self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        self[0 ..< max(0, toIndex)]
    }

    subscript(range: Range<Int>) -> String {
        let fullRange = Range(
            uncheckedBounds: (lower: max(0, min(length, range.lowerBound)),
                              upper: min(length, max(0, range.upperBound)))
        )
        let start = index(startIndex, offsetBy: fullRange.lowerBound)
        let end = index(start, offsetBy: fullRange.upperBound - fullRange.lowerBound)
        return String(self[start ..< end])
    }

    func isEmptyOrWhitespace() -> Bool {
        // Check empty string
        if isEmpty {
            return true
        }
        // Trim and check empty string
        return (trimmingCharacters(in: .whitespaces) == "")
    }
}
