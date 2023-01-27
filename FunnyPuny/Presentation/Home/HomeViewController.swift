// HomeViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import RealmSwift
import SwiftDate
import UIKit

// MARK: - HomeViewController

class HomeViewController: ViewController {
    enum ViewState {
        case emptyState
        case chillState
        case regularState
    }

    private var currentHabits: [Habit] = []
    private var selectedDate = Date()

    private var habitManager = HabitManager()
    private var calendarManager = CalendarManager()

    private var viewState: ViewState = .emptyState

    private var homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.home
        view = homeView
        setupTableView()
        setupData()
        setupCalendar()
        setupNotification()
        setupTargets()
    }

    @objc private func habitDidAdd() {
        setupCurrentHabits()
    }

    private func setupHomeStyle() {
        if habitManager.habits.isEmpty {
            viewState = .emptyState
        } else {
            if currentHabits.count != 0 {
                viewState = .regularState
            } else {
                viewState = .chillState
            }
        }
        homeView.configure(with: viewState)
        homeView.tableView.reloadData()
    }

    private func setupCurrentHabits() {
        let currentFrequency = Frequency(rawValue: selectedDate.weekday) ?? .sun
        currentHabits = habitManager.habits.filter {
            selectedDate.shortForm >= $0.createdDate.shortForm && $0.frequency.contains(currentFrequency)
        }
        currentHabits = currentHabits.sorted { $0.name < $1.name }
        setupHomeStyle()
    }

    private func setupData() {
        setupCurrentHabits()
    }

    private func setupTableView() {
        homeView.tableView.dataSource = self
        homeView.tableView.delegate = self
    }

    private func setupCalendar() {
        homeView.calendarView.monthView.calendarDelegate = self
        homeView.calendarView.monthView.calendarDataSource = self
        homeView.calendarView.headerView.addHabitButton.addTarget(
            self,
            action: #selector(addButtonPressed),
            for: .touchUpInside
        )
        didSelect(Date())
    }

    private func setupNotification() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(habitDidAdd),
            name: .habitDidAdd,
            object: nil
        )
    }

    private func setupTargets() {
        let headerTap = UITapGestureRecognizer(target: self, action: #selector(headerDatePressed))
        homeView.calendarView.headerView.addGestureRecognizer(headerTap)
    }

    @objc
    private func headerDatePressed() {
        didSelect(Date())
    }

    @objc
    private func addButtonPressed() {
        let addHabitViewController = NavigationController(rootViewController: AddHabitViewController())
        if let sheet = addHabitViewController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(addHabitViewController, animated: true)
    }

    private func didSelect(_ date: Date) {
        selectedDate = date
        homeView.calendarView.monthView.reloadData(withAnchor: selectedDate)
        homeView.calendarView.headerView.dateLabel.text = date.string(dateFormat: .formatLLLLd)
        setupCurrentHabits()
        addHapticFeedback(style: .soft)
    }
}

// MARK: UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedDate > Date() {
            presentAlert()
        } else {
            do {
                try realm.write {
                    let cell = tableView.cellForRow(at: indexPath, withClass: HomeCell.self)
                    let dateString = selectedDate.string(dateFormat: .formatyyMMdd)
                    let habitId = currentHabits[indexPath.row].id

                    if let days = habitManager.getSpecificElement(type: Days.self, with: dateString) {
                        if cell.state == .checked {
                            days.habits.remove(value: habitId)
                        } else {
                            days.habits.append(habitId)
                        }
                    } else {
                        let days = Days(date: dateString)
                        days.habits.append(habitId)
                        realm.add(days)
                    }
                }
            } catch let error as NSError {
                print("Can't update habit, error: \(error)")
            }
            homeView.calendarView.monthView.reloadDates([selectedDate])
            tableView.reloadData()
        }
        addHapticFeedback(style: .heavy)
    }
}

// MARK: UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        currentHabits.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeCell.self)
        var viewModel = HomeCellViewModel(
            habitName: currentHabits[indexPath.row].name,
            isDone: false,
            selectedDate: selectedDate
        )

        let date = selectedDate.string(dateFormat: .formatyyMMdd)
        let habitId = currentHabits[indexPath.row].id
        let days = habitManager.getSpecificElement(type: Days.self, with: date)
        if let days, days.habits.contains(habitId) {
            viewModel.isDone = true
            cell.configure(with: viewModel)
        } else {
            viewModel.isDone = false
            cell.configure(with: viewModel)
        }
        return cell
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let currentHabit = currentHabits[indexPath.row].name
        let trashAction = UIContextualAction(
            style: .normal,
            title: Texts.edit,
            handler: { (action: UIContextualAction, view: UIView, success: (Bool) -> Void) in
                let editingHabitViewController = NavigationController(
                    rootViewController: EditingHabitViewController(habitName: currentHabit)
                )
                if let sheet = editingHabitViewController.sheetPresentationController {
                    sheet.detents = [.large()]
                }
                self.present(editingHabitViewController, animated: true)
                success(true)
            }
        )
        trashAction.backgroundColor = Colors.backgroundIsland.color
        return UISwipeActionsConfiguration(actions: [trashAction])
    }
}

// MARK: JTACMonthViewDelegate

extension HomeViewController: JTACMonthViewDelegate {
    func calendar(
        _ calendar: JTACMonthView,
        cellForItemAt date: Date,
        cellState: CellState,
        indexPath: IndexPath
    ) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withClass: CalendarHomeDateCell.self, indexPath: indexPath)
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }

    func calendar(
        _: JTACMonthView,
        willDisplay cell: JTACDayCell,
        forItemAt date: Date,
        cellState: CellState,
        indexPath _: IndexPath
    ) {
        guard let cell = cell as? CalendarHomeDateCell else { return }
        cell.configure(with:
            .init(
                date: cellState.date,
                isDateBelongsToCurrentMonth: false,
                backgroundColor: calendarManager.getColorForAllHabitMode(by: cellState.date),
                isSelected: date.dayOfYear == selectedDate.dayOfYear
            )
        )
    }

    func calendar(
        _ calendar: JTACMonthView,
        didSelectDate date: Date,
        cell: JTACDayCell?,
        cellState: CellState,
        indexPath: IndexPath
    ) {
        guard date.shortForm != selectedDate.shortForm else { return }
        didSelect(date)
    }

    func calendar(_ calendar: JTACMonthView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        didSelect(calendar.cellStatusForDate(at: 0, column: 0)?.date ?? Date())
    }
}

// MARK: JTACMonthViewDataSource

extension HomeViewController: JTACMonthViewDataSource {
    func configureCalendar(_: JTAppleCalendar.JTACMonthView) -> JTAppleCalendar.ConfigurationParameters {
        let parameters = ConfigurationParameters(
            startDate: Date() - 1.years,
            endDate: Date() + 1.years,
            numberOfRows: 1
        )
        return parameters
    }
}
