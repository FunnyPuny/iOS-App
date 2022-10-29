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
        appearance.titleTextAttributes = [.foregroundColor: UIColor.foreground as Any]
        appearance.backgroundColor = .background
        navigationBar.standardAppearance = appearance
        view.backgroundColor = .background
    }
}
