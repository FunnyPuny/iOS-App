// CalendarManager.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift
import UIKit

struct CalendarManager {
    let habitManager = HabitManager()

    func getColorForAllHabitMode(by date: Date) -> UIColor {
        let days = habitManager.getSpecificElement(
            type: Days.self,
            with: date.string(dateFormat: .formatyyMMdd)
        )
        let habitsByDay = days?.habits.count ?? 0
        let habits = habitManager.habits
        var countAllHabits = 0
        for habit in habits {
            // TODO: filter
            for frequency in habit.frequency where frequency.rawValue == date.weekday {
                countAllHabits += 1
            }
        }
        let devision = Double(habitsByDay) / Double(countAllHabits)
        switch devision {
        case 1:
            return Colors.backgroundAccent.color
        case 0.1 ..< 0.35:
            return Colors.backgroundAccent.color.withAlphaComponent(0.4)
        case 0.35 ..< 0.65:
            return Colors.backgroundAccent.color.withAlphaComponent(0.6)
        case 0.65 ..< 1:
            return Colors.backgroundAccent.color.withAlphaComponent(0.8)
        default:
            return Colors.backgroundGlobe.color
        }
    }

    func getColorForCustomMode(by name: String, and date: Date) -> UIColor {
        if
            let day = habitManager.getSpecificElement(type: Days.self, with: date.string(dateFormat: .formatyyMMdd)),
            let habitId = habitManager.getHabitId(by: name),
            day.habits.contains(habitId)
        {
            return Colors.backgroundAccent.color
        } else {
            return Colors.backgroundGlobe.color
        }
    }
}
