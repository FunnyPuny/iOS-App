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

    private var analyticMode: AnalyticMode = .allHabits
    private enum AnalyticMode {
        case allHabits
        case customHabit(name: String)
    }

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

        switch analyticMode {
        case .allHabits:
            let viewModel = AnalyticsViewModel(
                selectedHabit: Texts.allHabits,
                completedScore: habitManager.countCompletedHabits,
                missedScore: habitManager.countMissedHabits,
                statusValue: habitManager.countValueAllHabits,
                allHabitsName: habitManager.allHabitsName
            )
            analyticsView.configure(with: viewModel)
        case let .customHabit(name):
            let viewModel = AnalyticsViewModel(
                selectedHabit: name,
                completedScore: habitManager.countCompletedHabitBy(name),
                missedScore: habitManager.countMissedHabitsBy(name),
                statusValue: habitManager.countValueBy(name),
                allHabitsName: habitManager.allHabitsName
            )
            analyticsView.configure(with: viewModel)
        }
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
        analyticMode = title == Texts.allHabits ? .allHabits : .customHabit(name: title)
        setupData()
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
        MonthSize(defaultSize: 72)
    }
}
