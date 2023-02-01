// HabitManager.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift
import SwiftDate

class HabitManager {
    // swiftlint:disable force_try
    let realm = try! Realm()
    // swiftlint:enable force_try

    // MARK: Public properties

    lazy var habits = realm.objects(Habit.self)
    lazy var days = realm.objects(Days.self)

    var allHabitsName: [String] {
        habits.map(\.name).sorted(by: <)
    }

    func getSpecificElement<T: Object>(type: T.Type, with primaryKey: String) -> T? {
        realm.object(
            ofType: type,
            forPrimaryKey: primaryKey
        )
    }

    func countValueBy(_ habitName: String) -> Float {
        guard countGoalBy(habitName) != 0 else { return 0.0 }
        return Float(countCompletedHabitBy(habitName)) / Float(countGoalBy(habitName))
    }

    func countCompletedHabitBy(_ habitName: String) -> Int {
        var totalCount = 0
        for day in days {
            for habit in day.habits where habit == getHabitId(by: habitName) {
                totalCount += 1
            }
        }
        return totalCount
    }

    func countMissedHabitsBy(_ habitName: String) -> Int {
        countGoalBy(habitName) - countCompletedHabitBy(habitName)
    }

    var countCompletedHabits: Int {
        var totalCount = 0
        for day in days {
            totalCount += day.habits.count
        }
        return totalCount
    }

    var countMissedHabits: Int {
        countHabits - countCompletedHabits
    }

    var countValueAllHabits: Float {
        guard countHabits != 0 else { return 0.0 }
        return Float(countCompletedHabits) / Float(countHabits)
    }

    func saveHabit(name: String, frequency: List<Frequency>, createdDate: Date, handler: () -> Void) {
        do {
            try realm.write {
                let newHabit = Habit(
                    name: name,
                    frequency: frequency,
                    createdDate: createdDate
                )
                realm.add(newHabit)
                handler()
            }
        } catch let error as NSError {
            print("Can not create habit, error: \(error)")
        }
    }

    func getHabitId(by name: String) -> ObjectId? {
        for habit in habits where habit.name == name {
            return habit.id
        }
        return nil
    }

    // MARK: Private properties

    private var countHabits: Int {
        var totalCount = 0
        for habit in habits {
            totalCount += countGoalBy(habit.name)
        }
        return totalCount
    }

    private func countGoalBy(_ habitName: String) -> Int {
        var totalCount = 0
        if let habitId = getHabitId(by: habitName) {
            if let habit = realm.object(ofType: Habit.self, forPrimaryKey: habitId) {
                let currentDate = Date().localDate
                let daysPeriod = getFrequency(startDate: habit.createdDate, endDate: currentDate)
                for frequency in habit.frequency {
                    for day in daysPeriod where frequency.rawValue == day {
                        totalCount += 1
                    }
                }
            }
        }
        return totalCount
    }

    // swiftlint:disable shorthand_operator
    private func getFrequency(startDate: Date, endDate: Date) -> [Int] {
        var frequency: [Int] = []
        var date = endDate
        while date.shortForm >= startDate.shortForm {
            frequency.append(date.weekday)
            date = date - 1.days
        }
        return frequency
    }
}
