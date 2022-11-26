// NavigationController.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyle()
    }

    private func setupStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .backgroundGlobe
        appearance.titleTextAttributes = [
            .font: UIFont.bold17 ?? .systemFont(ofSize: 17),
            .foregroundColor: UIColor.textAccent ?? .clear
        ]
        navigationBar.standardAppearance = appearance
        view.backgroundColor = .backgroundGlobe
    }
}
