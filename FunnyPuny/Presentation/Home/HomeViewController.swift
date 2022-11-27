// HomeViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import RealmSwift
import SwiftDate
import UIKit

// MARK: - HomeViewController

class HomeViewController: ViewController {
    private var homeView = HomeView()
    var habits: Results<Habit>?
    var currentHabits = [Habit]()
    var selectedDate = Date()

    var habitManager = HabitManager()
    var calendarManager = CalendarManager()

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
        homeView.tableView.reloadData()
    }

    private func setupCurrentHabits() {
        let currentFrequency = Frequency(rawValue: selectedDate.weekday) ?? .sun
        currentHabits = habitManager.habits.filter {
            selectedDate >= $0.createdDate && $0.frequency.contains(currentFrequency)
        }
        homeView.tableView.reloadData()
    }

    private func setupData() {
        habits = realm.objects(Habit.self)
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
        scrollToDate(Date(), animated: false)
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
        scrollToDate(Date())
    }

    @objc
    private func addButtonPressed() {
        let addHabitViewController = NavigationController(rootViewController: AddHabitViewController())
        if let sheet = addHabitViewController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(addHabitViewController, animated: true)
    }

    private func scrollToDate(_ date: Date, animated: Bool = true) {
        selectedDate = date
        homeView.calendarView.monthView.reloadData()
        homeView.calendarView.monthView.scrollToDate(
            date - 3.days,
            animateScroll: animated,
            extraAddedOffset: -4
        )
        homeView.calendarView.headerView.dateLabel.text = date.string(dateFormat: .formatMMMMd)
        setupCurrentHabits()
    }

    func presentAlert() {
        let alert = UIAlertController(title: Texts.oops, message: Texts.alert, preferredStyle: .alert)
        alert.addAction(.init(title: Texts.ok, style: .cancel))
        present(alert, animated: true)
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
                        if cell.isDone {
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
        }
        homeView.calendarView.monthView.reloadDates([selectedDate])
        tableView.reloadData()
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
        let days = realm.object(ofType: Days.self, forPrimaryKey: date)
        if let days, days.habits.contains(habitId) {
            viewModel.isDone = true
            cell.configure(with: viewModel)
        } else {
            viewModel.isDone = false
            cell.configure(with: viewModel)
        }
        return cell
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
        scrollToDate(date)
    }
}

// MARK: JTACMonthViewDataSource

extension HomeViewController: JTACMonthViewDataSource {
    func configureCalendar(_: JTAppleCalendar.JTACMonthView) -> JTAppleCalendar.ConfigurationParameters {
        let parameters = ConfigurationParameters(
            startDate: Date() - 10.years,
            endDate: Date() + 10.years,
            numberOfRows: 1
        )
        return parameters
    }
}
