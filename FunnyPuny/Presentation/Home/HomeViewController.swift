// HomeViewController.swift
// Created by Zlata Guseva on 12.10.2022.

import JTAppleCalendar
import RealmSwift
import SwiftDate
import UIKit

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
        print(selectedDate.dateComponents.weekday)
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
        scrollToDate(Date())
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

    private func scrollToDate(_ date: Date) {
        homeView.calendarView.monthView.scrollToDate(date - 3.days, extraAddedOffset: -4) // TODO: 💩
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
        cell.iconImageView.image = currentHabits?[indexPath.row].isDone ?? false ? .checkmark : .circle
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            try realm.write {
                currentHabits?[indexPath.row].isDone.toggle()
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

    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? CalendarDateCell else { return }
        cell.dateLabel.text = cellState.date.string(dateFormat: .formatdd)
        cell.dayOfWeekLabel.text = cellState.date.string(dateFormat: .formatEEEEE)
        cell.dayOfWeekLabel.backgroundColor = Calendar.current.isDateInToday(cellState.date) ? .primaryText : .foreground
        cell.dayOfWeekLabel.textColor = Calendar.current.isDateInToday(cellState.date) ? .foreground : .primaryText
    }

    func calendar(
        _ calendar: JTACMonthView,
        cellForItemAt date: Date,
        cellState: CellState,
        indexPath: IndexPath
    ) -> JTACDayCell {
        // swiftlint:disable all
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CalendarDateCell", for: indexPath) as! CalendarDateCell // TODO: 💩
        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }

    func calendar(_: JTACMonthView, willDisplay cell: JTACDayCell, forItemAt _: Date, cellState: CellState, indexPath _: IndexPath) {
        configureCell(view: cell, cellState: cellState)
    }

    func calendar(_: JTACMonthView, didSelectDate date: Date, cell _: JTACDayCell?, cellState _: CellState, indexPath _: IndexPath) {
        scrollToDate(date)
    }
}
