// HomeViewController.swift
// Created by Zlata Guseva on 12.10.2022.

import SnapKit
import UIKit

class HomeViewController: ViewController {
    private var homeView = HomeView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.home
        view = homeView
    }
}
