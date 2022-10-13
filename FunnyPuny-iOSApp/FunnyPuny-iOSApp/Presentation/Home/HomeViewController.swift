// HomeViewController.swift
// Created by Zlata Guseva on 12.10.2022.

import SnapKit
import UIKit

class HomeViewController: UIViewController {
    lazy var homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
        view.backgroundColor = .mainBackGround
    }
}
