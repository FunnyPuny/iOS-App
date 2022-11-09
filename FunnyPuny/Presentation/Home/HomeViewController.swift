// HomeViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import JTAppleCalendar
import RealmSwift
import SwiftDate
import UIKit

// swiftlint:disable all
class HomeViewController: ViewController {
    private var homeView = HomeView()
    var habits: Results<Habit>?
    var currentHabits: Results<Habit>?
    var selectedDate = Date()

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

    fileprivate func setupCurrentHabits() {
        currentHabits = habits?.where {
            $0.frequency.contains(Day(rawValue: selectedDate.dateComponents.weekday ?? 1) ?? .sun)
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

    @objc private func headerDatePressed() {
        scrollToDate(Date())
    }

    private func scrollToDate(_ date: Date, animated: Bool = true) {
        homeView.calendarView.monthView.scrollToDate(
            date - 3.days,
            animateScroll: animated,
            extraAddedOffset: -4
        )
        homeView.calendarView.headerView.dateLabel.text = date.string(dateFormat: .formatMMMMd)
        selectedDate = date
        setupCurrentHabits()
    }

    func setBackgroundColorForDateCell(date: Date) -> UIColor? {
        let completedHabit = realm.object(ofType: CompletedHabits.self, forPrimaryKey: date.string(dateFormat: .formatyyMMdd))
        let countOfCompletedHabits = completedHabit?.habits.count ?? 0
        let allHabits = realm.objects(Habit.self)
        var countAllHabits = 0
        for habit in allHabits {
            for frequency in habit.frequency where frequency.rawValue == date.weekday {
                countAllHabits += 1
            }
        }
        let x = Double(countOfCompletedHabits) / Double(countAllHabits)
        switch x {
        case 1:
            return .pinkLight
        case 0.1 ..< 0.35:
            return .pinkLight?.withAlphaComponent(0.4)
        case 0.35 ..< 0.65:
            return .pinkLight?.withAlphaComponent(0.6)
        case 0.65 ..< 1:
            return .pinkLight?.withAlphaComponent(0.8)
        default: return .background
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        currentHabits?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeCell.self)
        cell.label.text = currentHabits?[indexPath.row].name ?? ""

        let date = selectedDate.string(dateFormat: .formatyyMMdd)
        let completedHabits = realm.object(ofType: CompletedHabits.self, forPrimaryKey: date)
        if
            let habitId = currentHabits?[indexPath.row].id,
            let completedHabits,
            completedHabits.habits.contains(habitId)
        {
            cell.iconImageView.image = .checkmark
            cell.iconImageView.tintColor = .vividPink
            cell.contentView.backgroundColor = .background
            cell.contentView.layer.borderColor = UIColor.pinkLight?.cgColor
            cell.contentView.layer.borderWidth = 2
            cell.isDone = true
        } else {
            cell.iconImageView.image = .circle
            cell.iconImageView.tintColor = .background
            cell.contentView.backgroundColor = .pinkLight
            cell.isDone = false
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath, withClass: HomeCell.self)
        do {
            try realm.write {
                let dateString = selectedDate.string(dateFormat: .formatyyMMdd)
                guard let habitId = (currentHabits?[indexPath.row].id) else {
                    return
                }

                if let history = realm.object(ofType: CompletedHabits.self, forPrimaryKey: dateString) {
                    if cell.isDone {
                        history.habits.remove(value: habitId)
                    } else {
                        history.habits.append(habitId)
                    }
                } else {
                    let history = CompletedHabits(date: dateString)
                    history.habits.append(habitId)
                    realm.add(history)
                }
            }
        } catch let error as NSError {
            print("Can't update habit, error: \(error)")
        }
        homeView.calendarView.monthView.reloadDates([selectedDate])
        tableView.reloadData()
    }
}

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

    func calendar(_: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt _: Date, cellState: CellState, indexPath _: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }

    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? CalendarHomeDateCell else { return }
        cell.dateLabel.text = cellState.date.string(dateFormat: .formatdd)
        cell.dayOfWeekLabel.text = cellState.date.string(dateFormat: .formatEEEEE)
        cell.dayOfWeekLabel.textColor = cellState.date.isToday ? .foreground : .greyDark
        cell.dateLabel.layer.borderColor = cellState.date.isToday ? UIColor.vividPink?.cgColor : UIColor.greyLight?.cgColor
        cell.dateLabel.backgroundColor = setBackgroundColorForDateCell(date: cellState.date)
    }

    func calendar(_: JTACMonthView, didSelectDate date: Date, cell _: JTACDayCell?, cellState _: CellState, indexPath _: IndexPath) {
        scrollToDate(date)
    }
}

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
