// AddNewHabitViewController.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class AddNewHabitViewController: ViewController {
    private var addNewHabitView = AddNewHabitView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.addHabit
        view = addNewHabitView
        setupNavigation()
    }

    private func setupNavigation() {
        let addNavigationItem = UIBarButtonItem(title: Texts.add, style: .plain, target: self, action: #selector(saveHabit))
        navigationItem.rightBarButtonItem = addNavigationItem
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    @objc
    func saveHabit() {
        dismiss(animated: true)
    }
}
