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
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.primaryText]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.primaryText]
        navigationBar.standardAppearance = appearance
        navigationBar.tintColor = .primaryText
        navigationBar.prefersLargeTitles = true
        view.backgroundColor = .mainBackground
    }
}
