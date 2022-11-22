// CalendarCellViewModel.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import UIKit

struct CalendarCellViewModel {
    let date: Date
    let isHidden: Bool

    init(date: Date, isHidden: Bool = false) {
        self.date = date
        self.isHidden = isHidden
    }

    var backgroundColor: UIColor? {
        let days = HabitManager().getSpecificElement(
            type: Days.self,
            with: date.string(dateFormat: .formatyyMMdd)
        )
        let habitsByDay = days?.habits.count ?? 0
        let habits = HabitManager().habits
        var countAllHabits = 0
        for habit in habits {
            for frequency in habit.frequency where frequency.rawValue == date.weekday {
                countAllHabits += 1
            }
        }
        let devision = Double(habitsByDay) / Double(countAllHabits)
        switch devision {
        case 1:
            return .backgroundIsland
        case 0.1 ..< 0.35:
            return .backgroundIsland?.withAlphaComponent(0.4)
        case 0.35 ..< 0.65:
            return .backgroundIsland?.withAlphaComponent(0.6)
        case 0.65 ..< 1:
            return .backgroundIsland?.withAlphaComponent(0.8)
        default:
            return .backgroundGlobe
        }
    }
}
