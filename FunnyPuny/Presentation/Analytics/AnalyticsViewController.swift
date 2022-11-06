// AnalyticsViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import SwiftDate
import UIKit
// swiftlint:disable all
class AnalyticsViewController: ViewController {
    private var analyticsView = AnalyticsView()
    var history: Results<History>?
    var habits: Results<Habit>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = analyticsView
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }

    func setupData() {
        analyticsView.commonAnalyticsView.completedScore.amountHabitsLabel.text = String(countTotalCompletedHabits())
        analyticsView.commonAnalyticsView.missedScore.amountHabitsLabel.text = String(countAllMissedHabits())
    }

    func countTotalCompletedHabits() -> Int {
        history = realm.objects(History.self)
        var totalCount = 0
        if let history {
            for history in history {
                totalCount += history.habits.count
            }
        }
        return totalCount
    }

    func countGoalByHabitName(_ habitName: String) -> Int {
        var totalCount = 0
        if let habit = = realm.object(ofType: Habit.self, forPrimaryKey: getHabit(by: habitName)?.id) {
            let period = daysBetween(start: habit.creatingDate, end: Date())
            let weeksPeriod = period / 7
            let daysPeriod = period % 7
            var array = [Int]()
            for value in 0 ... daysPeriod {
                array.append((Date() - value.days).weekday)
            }
            totalCount += habit.frequency.count * weeksPeriod
            print("total count for week = \(totalCount)")
            for i in 0 ... habit.frequency.count - 1 {
                for j in array {
                    if habit.frequency[i].rawValue == j {
                        totalCount += 1
                    }
                }
            }
        }
        return totalCount
    }

    func countAllHabit() -> Int {
        habits = realm.objects(Habit.self)
        var totalCount = 0
        if let habits {
            for habit in habits {
                totalCount += countGoalByHabitName(habit.name)
                print("Total count \(totalCount) for \(habit.name)")
            }
        }
        return totalCount
    }

    func countAllMissedHabits() -> Int {
        return countAllHabit() - countTotalCompletedHabits()
    }

    func getHabit(by name: String) -> Habit? {
        habits = realm.objects(Habit.self)
        if let habits {
            for habit in habits {
                if habit.name == name {
                    return habit
                }
            }
        }
        return nil
    }

    func daysBetween(start: Date, end: Date) -> Int {
        Calendar.current.dateComponents([.day], from: start, to: end).day! // TODO:
    }
}
