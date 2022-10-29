// TabBarController.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class TabBarController: UITabBarController {
    private var addButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.image = .plusApp
        configuration.preferredSymbolConfigurationForImage = .init(weight: .bold)
        configuration.baseBackgroundColor = .background
        configuration.baseForegroundColor = .pinkLight
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
        addButton.frame = CGRect(x: tabBar.center.x - 16, y: view.bounds.height - 80, width: 32, height: 32)
    }

    private func setupStyleTabBar() {
        tabBar.tintColor = .vividPink
        tabBar.unselectedItemTintColor = .greyLight
        tabBar.barTintColor = .background
    }

    private func setupTabBarItems() {
        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(
            title: Texts.habits,
            image: .heartList,
            tag: 0
        )

        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(
            title: Texts.profile,
            image: .smile,
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
