// AddNewHabitViewController.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class AddNewHabitViewController: ViewController {
    private var addNewHabitView = AddNewHabitView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add habit"
        view = addNewHabitView
    }
}
