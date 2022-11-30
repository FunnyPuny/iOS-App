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

        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(
            title: Texts.profile,
            image: Images.profile.image,
            tag: 2
        )

        viewControllers = [firstViewController, secondViewController, thirdViewController]
        selectedIndex = 2
    }
}
