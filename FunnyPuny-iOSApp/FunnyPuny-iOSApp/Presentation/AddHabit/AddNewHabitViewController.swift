// AddNewHabitViewController.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class AddNewHabitViewController: UIViewController {
    lazy var addNewHabitView = AddNewHabitView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = addNewHabitView
        view.backgroundColor = .mainBackGround
    }
}
