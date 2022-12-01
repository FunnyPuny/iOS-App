// AnalyticsViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import RealmSwift
import SwiftDate
import UIKit

// MARK: - AnalyticsViewController

enum AnalyticMode {
    case allHabits
    case customHabit(name: String)
}

class AnalyticsViewController: ViewController {
    private var analyticsView = AnalyticsView()
    private var habitManager = HabitManager()
    private var calendarManager = CalendarManager()

    private var analyticMode: AnalyticMode = .allHabits

    private var rangeStartDate = Date()

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
                percentValue: habitManager.countValueAllHabits,
                allHabitsName: habitManager.allHabitsName
            )
            analyticsView.configure(with: viewModel)
        case let .customHabit(name):
            let viewModel = AnalyticsViewModel(
                selectedHabit: name,
                completedScore: habitManager.countCompletedHabitBy(name),
                missedScore: habitManager.countMissedHabitsBy(name),
                percentValue: habitManager.countValueBy(name),
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

    @objc
    func goToNextMonth() {
        analyticsView.calendarView.monthView.scrollToDate(rangeStartDate + 1.months)
    }

    @objc
    func goToPreviousMonth() {
        analyticsView.calendarView.monthView.scrollToDate(rangeStartDate - 1.months)
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
        switch analyticMode {
        case .allHabits:
            cell.configure(with: .init(
                date: cellState.date,
                isDateBelongsToCurrentMonth: cellState.dateBelongsTo == .thisMonth,
                backgroundColor: calendarManager.getColorForAllHabitMode(by: cellState.date),
                isSelected: cellState.isSelected
            )
            )
        case let .customHabit(name):
            cell.configure(with: .init(
                date: cellState.date,
                isDateBelongsToCurrentMonth: cellState.dateBelongsTo == .thisMonth,
                backgroundColor: calendarManager.getColorForCustomMode(by: name, and: cellState.date),
                isSelected: cellState.isSelected
            )
            )
        }
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
        rangeStartDate = range.start
        header.monthView.monthLabel.text = rangeStartDate.string(dateFormat: .formatLLLLyyyy)
        header.monthView.rightButton.addTarget(self, action: #selector(goToNextMonth), for: .touchUpInside)
        header.monthView.leftButton.addTarget(self, action: #selector(goToPreviousMonth), for: .touchUpInside)
        return header
    }

    func calendarSizeForMonths(_: JTACMonthView?) -> MonthSize? {
        MonthSize(defaultSize: 72)
    }
}
