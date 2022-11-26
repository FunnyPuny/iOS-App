// CalendarCellViewModel.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift
import UIKit

struct CalendarCellViewModel {
    let date: Date
    let isHidden: Bool
    let backgroundColor: UIColor
    let isSelected: Bool

    init(date: Date, isHidden: Bool = false, backgroundColor: UIColor, isSelected: Bool) {
        self.date = date
        self.isHidden = isHidden
        self.backgroundColor = backgroundColor
        self.isSelected = isSelected
    }
}
