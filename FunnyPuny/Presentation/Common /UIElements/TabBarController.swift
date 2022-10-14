// TabBarController.swift
// Created by Zlata Guseva on 12.10.2022.

import UIKit

class TabBarController: UITabBarController {
    private var addButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = .plusApp
        configuration.preferredSymbolConfigurationForImage = .init(weight: .bold)
        configuration.baseBackgroundColor = .background
        configuration.baseForegroundColor = .tabForeground
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
        tabBar.unselectedItemTintColor = .tabForeground
    }

    private func setupTabBarItems() {
        let firstViewController = NavigationController(rootViewController: HomeViewController())
        firstViewController.tabBarItem = UITabBarItem(
            title: Texts.habits,
            image: .heartList,
            tag: 0
        )

        let thirdViewController = NavigationController(rootViewController: ProfileViewController())
        thirdViewController.tabBarItem = UITabBarItem(
            title: Texts.profile,
            image: .bookClosed,
            tag: 1
        )

        viewControllers = [firstViewController, thirdViewController]
        view.insertSubview(addButton, aboveSubview: tabBar)
    }

    @objc
    private func addButtonPressed() {
        let addHabitViewController = NavigationController(rootViewController: AddHabitViewController())
        if let sheet = addHabitViewController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(addHabitViewController, animated: true)
    }
}
