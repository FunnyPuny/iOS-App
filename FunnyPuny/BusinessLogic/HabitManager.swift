// HabitManager.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift
import SwiftDate

// swiftlint:disable all
// TODO:
class HabitManager {
    let realm = try! Realm()

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
        guard countHabits != 0 else { return 0.0 }
        return Float(countCompletedHabitBy(habitName)) / Float(countGoalBy(habitName))
    }

    func countCompletedHabitBy(_ habitName: String) -> Int {
        var totalCount = 0
        let days = days
        for row in days {
            for habit in row.habits where habit == getHabitId(by: habitName) {
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

    func saveHabit(name: String, frequency: List<Frequency>, handler: () -> Void) {
        do {
            try realm.write {
                let newHabit = Habit(
                    name: name,
                    frequency: frequency
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
                let localDate = Date().localDate
                let period = daysBetween(startDate: habit.createdDate.localDate, endDate: localDate)
                let missedWeeks = period / 7
                let daysPeriod = period % 7
                var missedDays = [Int]()
                for value in 0 ... daysPeriod {
                    missedDays.append((localDate - value.days).weekday)
                }
                totalCount += habit.frequency.count * missedWeeks
                for day in stride(from: 0, through: habit.frequency.count - 1, by: 1) {
                    for days in missedDays where habit.frequency[day].rawValue == days {
                        totalCount += 1
                    }
                }
            }
        }
        return totalCount
    }

    private func daysBetween(startDate: Date, endDate: Date) -> Int {
        (endDate - startDate).day ?? 0
    }
}
