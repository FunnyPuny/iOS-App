// AnalyticsViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import RealmSwift
import SwiftDate
import UIKit

// MARK: - AnalyticsViewController

class AnalyticsViewController: ViewController {
    private var analyticsView = AnalyticsView()
    private var habitManager = HabitManager()

    // TODO:
    var selectedHabitName = "Running"

    override func viewDidLoad() {
        super.viewDidLoad()
        view = analyticsView
        setupCalendar()
        setupMenuButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }

    func setupData() {
        // Refresh database
        habitManager = HabitManager()
        // Refresh calendar
        analyticsView.calendarView.monthView.reloadData()
        // Temp
        let viewModel = AnalyticsViewModel(
            selectedHabit: selectedHabitName,
            completedScore: habitManager.countCompletedHabitBy(selectedHabitName),
            missedScore: habitManager.countMissedHabitsBy(selectedHabitName),
            statusValue: habitManager.countValueBy(selectedHabitName),
            allHabitsName: habitManager.allHabitsName
        )
        analyticsView.configure(with: viewModel)
    }

    func switchSelectedHabit(by name: String) {
        selectedHabitName = name
        setupData()
    }

    func setupCalendar() {
        analyticsView.calendarView.monthView.calendarDelegate = self
        analyticsView.calendarView.monthView.calendarDataSource = self
        analyticsView.calendarView.monthView.scrollToDate(Date(), animateScroll: false)
    }

    func setupMenuButton() {
        analyticsView.menuButtonView.delegate = self
    }
}

// MARK: MenuButtonViewDelegate

extension AnalyticsViewController: MenuButtonViewDelegate {
    func menuButtonDidPressed(title: String) {
        switchSelectedHabit(by: title)
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
        guard let cell = cell as? CalendarAnalyticDateCell else { return }
        cell.configure(with: .init(date: cellState.date, isHidden: cellState.dateBelongsTo != .thisMonth))
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
        header.monthView.monthLabel.text = range.start.string(dateFormat: .formatMMMMyyyy)
        return header
    }

    func calendarSizeForMonths(_: JTACMonthView?) -> MonthSize? {
        MonthSize(defaultSize: 88)
    }
}
