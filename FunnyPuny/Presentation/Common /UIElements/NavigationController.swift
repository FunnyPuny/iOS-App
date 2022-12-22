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
        appearance.backgroundColor = Colors.backgroundGlobe.color
        appearance.titleTextAttributes = [
            .font: UIFont.bodyMedium ?? .systemFont(ofSize: 17),
            .foregroundColor: Colors.textPrimary.color
        ]
        navigationBar.standardAppearance = appearance
        view.backgroundColor = Colors.backgroundGlobe.color
    }
}
