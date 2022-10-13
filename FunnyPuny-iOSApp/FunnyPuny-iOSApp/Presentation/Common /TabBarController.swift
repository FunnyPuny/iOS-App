// TabBarController.swift
// Created by Zlata Guseva on 12.10.2022.

import UIKit

class TabBarController: UITabBarController {
    private var addButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = .init(systemName: "plus.app")
        configuration.preferredSymbolConfigurationForImage = .init(weight: .bold)
        configuration.baseBackgroundColor = .mainBackground
        configuration.baseForegroundColor = .gray
        button.configuration = configuration
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyleTabBar()
        setupTabBarItems()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addButton.frame = CGRect(x: tabBar.center.x - 32, y: view.bounds.height - 96, width: 64, height: 64)
    }

    private func setupStyleTabBar() {
        tabBar.tintColor = .primaryText
        tabBar.barTintColor = .white
    }

    private func setupTabBarItems() {
        let firstViewController = NavigationController(rootViewController: HomeViewController())
        firstViewController.tabBarItem = UITabBarItem(
            title: "Habits",
            image: .init(systemName: "heart.text.square"),
            tag: 0
        )

        let thirdViewController = NavigationController(rootViewController: ProfileViewController())
        thirdViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: .init(systemName: "book.closed"),
            tag: 1
        )

        viewControllers = [firstViewController, thirdViewController]
        view.insertSubview(addButton, aboveSubview: tabBar)
    }

    @objc
    private func addButtonPressed() {
        let addNewHabitViewController = NavigationController(rootViewController: AddNewHabitViewController())
        if let sheet = addNewHabitViewController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(addNewHabitViewController, animated: true)
    }
}
