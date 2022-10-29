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
        appearance.titleTextAttributes = [.foregroundColor: UIColor.foreground as Any]
        appearance.backgroundColor = .background
        navigationBar.standardAppearance = appearance
        view.backgroundColor = .background
    }
}
