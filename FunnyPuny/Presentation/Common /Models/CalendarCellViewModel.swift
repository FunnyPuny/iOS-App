// CalendarCellViewModel.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift
import UIKit

struct CalendarCellViewModel {
    let date: Date
    let isDateBelongsToCurrentMonth: Bool
    let backgroundColor: UIColor
    let isSelected: Bool

    init(date: Date, isDateBelongsToCurrentMonth: Bool, backgroundColor: UIColor, isSelected: Bool) {
        self.date = date
        self.isDateBelongsToCurrentMonth = isDateBelongsToCurrentMonth
        self.backgroundColor = backgroundColor
        self.isSelected = isSelected
    }
}
