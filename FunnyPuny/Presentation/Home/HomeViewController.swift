// HomeViewController.swift
// Created by Zlata Guseva on 12.10.2022.

import JTAppleCalendar
import RealmSwift
import SwiftDate
import UIKit

class HomeViewController: ViewController {
    private var homeView = HomeView()
    var habits: Results<Habit>?
    var selectedDate = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.home
        view = homeView
        setupTableView()
        setupData()
        setupCalendar()
        setupNotification()
    }

    @objc private func habitDidAdd() {
        homeView.tableView.reloadData()
    }

    private func setupData() {
        habits = realm.objects(Habit.self)
        homeView.tableView.reloadData()
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

    private func scrollToDate(_ date: Date) {
        homeView.calendarView.monthView.scrollToDate(date - 3.days, extraAddedOffset: -4) // TODO: 💩
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        habits?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeCell.self)
        // TODO:
        var selectedDayOfWeek = selectedDate.weekday
        print("selectedDate = \(selectedDate) | selectedDayOfWeek = \(selectedDayOfWeek)")
        cell.label.text = habits?[indexPath.row].name ?? ""
        cell.iconImageView.image = habits?[indexPath.row].isDone ?? false ? .checkmark : .circle
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        do {
            try realm.write {
                habits?[indexPath.row].isDone.toggle()
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
            numberOfRows: 1,
            firstDayOfWeek: .monday
        )
        return parameters
    }

    func configureCell(view: JTACDayCell?, cellState: CellState) {
        guard let cell = view as? CalendarDateCell else { return }
        cell.dateLabel.text = cellState.date.string(dateFormat: .formatdd)
        cell.dayOfWeekLabel.text = cellState.date.string(dateFormat: .formatEEEEE)
        cell.dayOfWeekLabel.backgroundColor = cellState.date.isToday ? .primaryText : .foreground
        cell.dayOfWeekLabel.textColor = cellState.date.isToday ? .foreground : .primaryText
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
        homeView.calendarView.headerView.dateLabel.text = date.string(dateFormat: .formatMMMMd)
        selectedDate = date
    }
}
