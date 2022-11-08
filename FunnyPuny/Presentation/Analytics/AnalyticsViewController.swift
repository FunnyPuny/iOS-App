// AnalyticsViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import SwiftDate
import UIKit

// swiftlint:disable all
class AnalyticsViewController: ViewController {
    private var analyticsView = AnalyticsView()
    var dbManager = DBManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = analyticsView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }

    func setupData() {
        // Refresh database
        dbManager = DBManager()
        // Temp
        analyticsView.categoryLabel.text = "Test2"
        analyticsView.commonAnalyticsView.completedScore.amountHabitsLabel.text = String(countCompletedHabitBy("Test2"))
        analyticsView.commonAnalyticsView.missedScore.amountHabitsLabel.text = String(countMissedHabitsBy("Test2"))
    }

    func countTotalCompletedHabits() -> Int {
        var totalCount = 0
        for history in dbManager.history {
            totalCount += history.habits.count
        }
        return totalCount
    }

    func countGoalByHabitName(_ habitName: String) -> Int {
        var totalCount = 0
        if let habitId = getHabitId(by: habitName) {
            if let habit = realm.object(ofType: Habit.self, forPrimaryKey: habitId) {
                let period = daysBetween(start: habit.creatingDate, end: Date())
                let weeksPeriod = period / 7
                let daysPeriod = period % 7
                var array = [Int]()
                for value in 0 ... daysPeriod {
                    array.append((Date() - value.days).weekday)
                }
                totalCount += habit.frequency.count * weeksPeriod
                for i in 0 ... habit.frequency.count - 1 {
                    for j in array {
                        if habit.frequency[i].rawValue == j {
                            totalCount += 1
                        }
                    }
                }
            }
        }
        return totalCount
    }

    func countCompletedHabitBy(_ habitName: String) -> Int {
        var totalCount = 0
        let history = realm.objects(CompletedHabits.self).toArray(type: CompletedHabits.self)
        for row in history {
            for habit in row.habits {
                if habit == getHabitId(by: habitName) {
                    totalCount += 1
                }
            }
        }
        return totalCount
    }

    func countMissedHabitsBy(_ habitName: String) -> Int {
        countGoalByHabitName(habitName) - countCompletedHabitBy(habitName)
    }

    func countAllHabit() -> Int {
        let habits = realm.objects(Habit.self)
        var totalCount = 0
        for habit in habits {
            totalCount += countGoalByHabitName(habit.name)
        }
        return totalCount
    }

    func countAllMissedHabits() -> Int {
        countAllHabit() - countTotalCompletedHabits()
    }

    func getHabitId(by name: String) -> ObjectId? {
        for habit in dbManager.habits where habit.name == name {
            return habit.id
        }
        return nil
    }

    func daysBetween(start: Date, end: Date) -> Int {
        guard let days = Calendar.current.dateComponents([.day], from: start, to: end).day else {
            return 0
        }
        return days
    }
}
