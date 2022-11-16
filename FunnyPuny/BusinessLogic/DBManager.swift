// DBManager.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import RealmSwift
import SwiftDate

// swiftlint:disable all
// TODO:
class DBManager {
    let realm = try! Realm()

    lazy var habits: [Habit] = realm.objects(Habit.self).toArray(type: Habit.self)
    lazy var history: [CompletedHabits] = realm.objects(CompletedHabits.self).toArray(type: CompletedHabits.self)
    var countCompletedHabits: Int {
        var totalCount = 0
        for history in history {
            totalCount += history.habits.count
        }
        return totalCount
    }

    var countHabits: Int {
        let habits = habits
        var totalCount = 0
        for habit in habits {
            totalCount += countGoalByHabitName(habit.name)
        }
        return totalCount
    }

    var countMissedHabits: Int {
        countHabits - countCompletedHabits
    }

    var allHabitValue: Float {
        Float(countCompletedHabits) / Float(countHabits)
    }

    init() {}

    func getHabitId(by name: String) -> ObjectId? {
        for habit in habits where habit.name == name {
            return habit.id
        }
        return nil
    }

    func countGoalByHabitName(_ habitName: String) -> Int {
        var totalCount = 0
        if let habitId = getHabitId(by: habitName) {
            if let habit = realm.object(ofType: Habit.self, forPrimaryKey: habitId) {
                let period = daysBetween(startDate: habit.createdDate, endDate: Date())
                let missedWeeks = period / 7
                let daysPeriod = period % 7
                var missedDays = [Int]()
                for value in 0 ... daysPeriod {
                    missedDays.append((Date() - value.days).weekday)
                }
                totalCount += habit.frequency.count * missedWeeks
                for day in 0 ... habit.frequency.count - 1 {
                    for days in missedDays where habit.frequency[day].rawValue == days {
                        totalCount += 1
                    }
                }
            }
        }
        return totalCount
    }

    func countCompletedHabitBy(_ habitName: String) -> Int {
        var totalCount = 0
        let history = history
        for row in history {
            for habit in row.habits where habit == getHabitId(by: habitName) {
                totalCount += 1
            }
        }
        return totalCount
    }

    func countMissedHabitsBy(_ habitName: String) -> Int {
        countGoalByHabitName(habitName) - countCompletedHabitBy(habitName)
    }

    func daysBetween(startDate: Date, endDate: Date) -> Int {
        guard let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day else {
            return 0
        }
        return days
    }
}
