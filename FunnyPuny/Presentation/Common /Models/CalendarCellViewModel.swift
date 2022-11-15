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
        let realm = DBManager().realm
        let completedHabit = realm.object(
            ofType: CompletedHabits.self,
            forPrimaryKey: date.string(dateFormat: .formatyyMMdd)
        )
        let countOfCompletedHabits = completedHabit?.habits.count ?? 0
        let allHabits = realm.objects(Habit.self)
        var countAllHabits = 0
        for habit in allHabits {
            for frequency in habit.frequency where frequency.rawValue == date.weekday {
                countAllHabits += 1
            }
        }
        let devision = Double(countOfCompletedHabits) / Double(countAllHabits)
        switch devision {
        case 1:
            return .pinkLight
        case 0.1 ..< 0.35:
            return .pinkLight?.withAlphaComponent(0.4)
        case 0.35 ..< 0.65:
            return .pinkLight?.withAlphaComponent(0.6)
        case 0.65 ..< 1:
            return .pinkLight?.withAlphaComponent(0.8)
        default:
            return .background
        }
    }
}
