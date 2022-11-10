// TabBarController.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyleTabBar()
        setupTabBarItems()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
            image: .home,
            tag: 0
        )

        let secondViewController = AnalyticsViewController()
        secondViewController.tabBarItem = UITabBarItem(
            title: Texts.analytics,
            image: .analytics,
            tag: 1
        )

        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(
            title: Texts.profile,
            image: .profile,
            tag: 2
        )

        viewControllers = [firstViewController, secondViewController, thirdViewController]
        selectedIndex = 0
    }
}
