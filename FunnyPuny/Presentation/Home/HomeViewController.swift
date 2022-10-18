// HomeViewController.swift
// Created by Zlata Guseva on 12.10.2022.

import RealmSwift
import SnapKit
import UIKit

class HomeViewController: ViewController {
    private var homeView = HomeView()
    var habits: Results<Habit>?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.home
        view = homeView

        setupTableView()
        setupData()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(habitDidAdd),
            name: .habitDidAdd,
            object: nil
        )
    }

    @objc func habitDidAdd() {
        homeView.tableView.reloadData()
    }

    func setupData() {
        habits = realm.objects(Habit.self)
        homeView.tableView.reloadData()
    }

    func setupTableView() {
        homeView.tableView.dataSource = self
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        habits?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeCell.self)
        cell.label.text = habits?[indexPath.row].name ?? ""
        return cell
    }
}
