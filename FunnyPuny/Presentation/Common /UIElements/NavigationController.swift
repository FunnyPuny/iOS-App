// NavigationController.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }

    private func setupStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.primaryPink as Any]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.primaryPink as Any]
        appearance.backgroundColor = .background
        appearance.shadowColor = .clear
        navigationBar.standardAppearance = appearance
        navigationBar.tintColor = .mainText
        navigationBar.prefersLargeTitles = true
        view.backgroundColor = .background
    }
}
