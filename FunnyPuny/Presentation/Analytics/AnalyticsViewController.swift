// AnalyticsViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import RealmSwift
import SwiftDate
import UIKit

// MARK: - AnalyticsViewController

class AnalyticsViewController: ViewController {
    private var analyticsView = AnalyticsView()
    var dbManager = DBManager()
    var value: Float?

    override func viewDidLoad() {
        super.viewDidLoad()
        view = analyticsView
        setupCalendar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
        analyticsView.achivmentView.progressView.progressAnimation(
            duration: 1,
            value: Float(countCompletedHabits) / Float(countHabits)
        )
    }

    func setupData() {
        // Refresh database
        dbManager = DBManager()
        // Temp
        value = Float(countCompletedHabits) / Float(countHabits)
        analyticsView.achivmentView.completedScore.amountHabitsLabel.text = String(countCompletedHabits)
        analyticsView.achivmentView.missedScore.amountHabitsLabel.text = String(countMissedHabits)
        analyticsView.achivmentView.progressView.statusLabel.text = String(Int((value ?? 1) * 100)) + "%"
    }

    func setupCalendar() {
        analyticsView.calendarView.monthView.calendarDelegate = self
        analyticsView.calendarView.monthView.calendarDataSource = self
        analyticsView.calendarView.monthView.scrollToDate(Date(), animateScroll: false)
    }

    private var countCompletedHabits: Int {
        var totalCount = 0
        for history in dbManager.history {
            totalCount += history.habits.count
        }
        return totalCount
    }

    private var countHabits: Int {
        let habits = realm.objects(Habit.self)
        var totalCount = 0
        for habit in habits {
            totalCount += countGoalByHabitName(habit.name)
        }
        return totalCount
    }

    private var countMissedHabits: Int {
        countHabits - countCompletedHabits
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
        let history = realm.objects(CompletedHabits.self).toArray(type: CompletedHabits.self)
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

    func getHabitId(by name: String) -> ObjectId? {
        for habit in dbManager.habits where habit.name == name {
            return habit.id
        }
        return nil
    }

    func daysBetween(startDate: Date, endDate: Date) -> Int {
        guard let days = Calendar.current.dateComponents([.day], from: startDate, to: endDate).day else {
            return 0
        }
        return days
    }
}

// MARK: JTACMonthViewDataSource

extension AnalyticsViewController: JTACMonthViewDataSource {
    func configureCalendar(_: JTAppleCalendar.JTACMonthView) -> JTAppleCalendar.ConfigurationParameters {
        let parameters = ConfigurationParameters(
            startDate: Date() - 1.years,
            endDate: Date() + 1.years
        )
        return parameters
    }
}

// MARK: JTACMonthViewDelegate

extension AnalyticsViewController: JTACMonthViewDelegate {
    func calendar(
        _ calendar: JTACMonthView,
        cellForItemAt date: Date,
        cellState: CellState,
        indexPath: IndexPath
    ) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withClass: CalendarAnalyticDateCell.self, indexPath: indexPath)
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }

    func calendar(
        _: JTACMonthView,
        willDisplay cell: JTACDayCell,
        forItemAt _: Date,
        cellState: CellState,
        indexPath _: IndexPath
    ) {
        configureCell(view: cell, cellState: cellState)
    }

    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? CalendarAnalyticDateCell else { return }
        cell.isHidden = cellState.dateBelongsTo == .thisMonth ? false : true
        cell.dateLabel.text = cellState.date.string(dateFormat: .formatdd)
    }

    func calendar(
        _ calendar: JTACMonthView,
        headerViewForDateRange range: (start: Date, end: Date),
        at indexPath: IndexPath
    ) -> JTACMonthReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(
            withClass: CalendarAnalyticHeaderView.self,
            indexPath: indexPath
        )
        header.monthLabel.text = range.start.string(dateFormat: .formatMMMMyyyy)
        return header
    }

    func calendarSizeForMonths(_: JTACMonthView?) -> MonthSize? {
        MonthSize(defaultSize: 88)
    }
}
