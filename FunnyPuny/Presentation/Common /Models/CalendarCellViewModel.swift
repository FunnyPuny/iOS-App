// CalendarCellViewModel.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift
import UIKit

struct CalendarCellViewModel {
    let date: Date
    let isHidden: Bool
    let backgroundColor: UIColor

    init(date: Date, isHidden: Bool = false, backgroundColor: UIColor) {
        self.date = date
        self.isHidden = isHidden
        self.backgroundColor = backgroundColor
    }
}
