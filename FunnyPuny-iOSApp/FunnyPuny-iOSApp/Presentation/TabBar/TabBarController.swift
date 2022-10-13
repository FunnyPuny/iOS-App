// TabBarController.swift
// Created by Zlata Guseva on 12.10.2022.

import UIKit

class TabBarController: UITabBarController {
    lazy var addButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = .init(systemName: "plus.app")
        configuration.preferredSymbolConfigurationForImage = .init(weight: .bold)
        configuration.baseBackgroundColor = .mainBackGround
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

    func setupStyleTabBar() {
        tabBar.tintColor = .primaryText
        tabBar.barTintColor = .white
    }

    func setupTabBarItems() {
        view.insertSubview(addButton, aboveSubview: tabBar)
        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(
            title: "Habits",
            image: .init(systemName: "heart.text.square"),
            tag: 0
        )

        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: .init(systemName: "book.closed"),
            tag: 1
        )

        viewControllers = [firstViewController, thirdViewController]
    }

    @objc
    private func addButtonPressed() {
        let addNewHabitViewController = AddNewHabitViewController()
        if let sheet = addNewHabitViewController.sheetPresentationController {
            sheet.detents = [.large()]
        }
        present(addNewHabitViewController, animated: true, completion: nil)
    }
}
