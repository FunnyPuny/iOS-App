//// ProfileViewController.swift
//// FunnyPuny. Created by Zlata Guseva.
//
//import UIKit
//import JTAppleCalendar
//import RealmSwift
//import SwiftDate
//
//class ProfileViewController: ViewController {
//    private var profileView = ProfileView()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        title = Texts.profile
//        view = profileView
//    }
//
//        var profileOptions = [String]()
//
//
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            view = profileView
//            setupTableView()
//            setupData()
//            setupCalendar()
//            setupNotification()
//            setupTargets()
//        }
//
//
//
//        private func setupCurrentHabits() {
//            let currentFrequency = Frequency(rawValue: selectedDate.weekday) ?? .sun
//            currentHabits = habitManager.habits.filter {
//                selectedDate >= $0.createdDate && $0.frequency.contains(currentFrequency)
//            }
//            homeView.tableView.reloadData()
//        }
//
//        private func setupData() {
//            habits = realm.objects(Habit.self)
//            setupCurrentHabits()
//        }
//
//        private func setupTableView() {
//            homeView.tableView.dataSource = self
//            homeView.tableView.delegate = self
//        }
//
//        private func setupCalendar() {
//            homeView.calendarView.monthView.calendarDelegate = self
//            homeView.calendarView.monthView.calendarDataSource = self
//            homeView.calendarView.headerView.addHabitButton.addTarget(
//                self,
//                action: #selector(addButtonPressed),
//                for: .touchUpInside
//            )
//            scrollToDate(Date(), animated: false)
//        }
//    }
//
//    // MARK: UITableViewDelegate
//
//    extension HomeViewController: UITableViewDelegate {
//        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            if selectedDate > Date() {
//                presentAlert()
//            } else {
//                do {
//                    try realm.write {
//                        let cell = tableView.cellForRow(at: indexPath, withClass: HomeCell.self)
//                        let dateString = selectedDate.string(dateFormat: .formatyyMMdd)
//                        let habitId = currentHabits[indexPath.row].id
//
//                        if let days = habitManager.getSpecificElement(type: Days.self, with: dateString) {
//                            if cell.isDone {
//                                days.habits.remove(value: habitId)
//                            } else {
//                                days.habits.append(habitId)
//                            }
//                        } else {
//                            let days = Days(date: dateString)
//                            days.habits.append(habitId)
//                            realm.add(days)
//                        }
//                    }
//                } catch let error as NSError {
//                    print("Can't update habit, error: \(error)")
//                }
//            }
//            homeView.calendarView.monthView.reloadDates([selectedDate])
//            tableView.reloadData()
//        }
//    }
//
//    // MARK: UITableViewDataSource
//
//    extension HomeViewController: UITableViewDataSource {
//        func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
//            currentHabits.count
//        }
//
//        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let cell = tableView.dequeueReusableCell(withClass: HomeCell.self)
//            var viewModel = HomeCellViewModel(
//                habitName: currentHabits[indexPath.row].name,
//                isDone: false,
//                selectedDate: selectedDate
//            )
//
//            let date = selectedDate.string(dateFormat: .formatyyMMdd)
//            let habitId = currentHabits[indexPath.row].id
//            let days = realm.object(ofType: Days.self, forPrimaryKey: date)
//            if let days, days.habits.contains(habitId) {
//                viewModel.isDone = true
//                cell.configure(with: viewModel)
//            } else {
//                viewModel.isDone = false
//                cell.configure(with: viewModel)
//            }
//            return cell
//        }
//    }
