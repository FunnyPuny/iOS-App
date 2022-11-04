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
    var history: Results<History>?
    var historyComplete = History()

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
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        currentHabits?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeCell.self)
        cell.label.text = currentHabits?[indexPath.row].name ?? ""

        let date = selectedDate.string(dateFormat: .formatyyMMdd)
        let history = realm.object(ofType: History.self, forPrimaryKey: date)
        if
            let habitId = currentHabits?[indexPath.row].id,
            let history,
            history.habits.contains(habitId)
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

                if let history = realm.object(ofType: History.self, forPrimaryKey: dateString) {
                    if cell.isDone {
                        history.habits.remove(value: habitId)
                    } else {
                        history.habits.append(habitId)
                    }
                } else {
                    let history = History(date: dateString)
                    history.habits.append(habitId)
                    realm.add(history)
                }
            }
        } catch let error as NSError {
            print("Can't update habit, error: \(error)")
        }
        tableView.reloadData()
    }
}

extension HomeViewController: JTACMonthViewDelegate, JTACMonthViewDataSource {
    func configureCalendar(_: JTAppleCalendar.JTACMonthView) -> JTAppleCalendar.ConfigurationParameters {
        let parameters = ConfigurationParameters(
            startDate: Date() - 10.years,
            endDate: Date() + 10.years,
            numberOfRows: 1
        )
        return parameters
    }

    func calendar(
        _ calendar: JTACMonthView,
        cellForItemAt date: Date,
        cellState: CellState,
        indexPath: IndexPath
    ) -> JTACDayCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarDateCell", for: indexPath) as! CalendarDateCell // TODO: 💩
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }

    func calendar(_: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt _: Date, cellState: CellState, indexPath _: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }

    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? CalendarDateCell else { return }
        cell.dateLabel.text = cellState.date.string(dateFormat: .formatdd)
        cell.dayOfWeekLabel.text = cellState.date.string(dateFormat: .formatEEEEE)
        cell.dayOfWeekLabel.textColor = Calendar.current.isDateInToday(cellState.date) ? .foreground : .greyDark
    }

    func calendar(_: JTACMonthView, didSelectDate date: Date, cell _: JTACDayCell?, cellState _: CellState, indexPath _: IndexPath) {
        scrollToDate(date)
    }
}
