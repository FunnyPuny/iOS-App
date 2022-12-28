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
        tabBar.tintColor = Colors.iconsActive.color
        tabBar.unselectedItemTintColor = Colors.iconsInactive.color
        tabBar.barTintColor = Colors.backgroundGlobe.color
        tabBar.tintAdjustmentMode = .normal
    }

    private func setupTabBarItems() {
        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(
            title: Texts.habits,
            image: Images.home.image,
            tag: 0
        )

        let secondViewController = AnalyticsViewController()
        secondViewController.tabBarItem = UITabBarItem(
            title: Texts.analytics,
            image: Images.analytics.image,
            tag: 1
        )

        viewControllers = [firstViewController, secondViewController]
        selectedIndex = 0
    }
}
