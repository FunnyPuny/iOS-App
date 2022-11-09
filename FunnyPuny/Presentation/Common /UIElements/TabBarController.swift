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
        addButton.snp.makeConstraints { make in
            make.size.equalTo(36)
            make.leading.equalTo(tabBar.snp.leading).inset(48)
            make.bottom.equalTo(tabBar.snp.bottom).inset(48)
        }
    }

    private func setupStyleTabBar() {
        tabBar.tintColor = .vividPink
        tabBar.unselectedItemTintColor = .greyLight
        tabBar.barTintColor = .background
    }

    private func setupTabBarItems() {
        let zeroViewController = ViewController()
        zeroViewController.tabBarItem = UITabBarItem()

        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(
            title: Texts.habits,
            image: .home,
            tag: 1
        )

        let secondViewController = AnalyticsViewController()
        secondViewController.tabBarItem = UITabBarItem(
            title: Texts.analytics,
            image: .analytics,
            tag: 2
        )

        let thirdViewController = ProfileViewController()
        thirdViewController.tabBarItem = UITabBarItem(
            title: Texts.profile,
            image: .profile,
            tag: 3
        )

        viewControllers = [zeroViewController, firstViewController, secondViewController, thirdViewController]
        view.insertSubview(addButton, aboveSubview: tabBar)
        selectedIndex = 1
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
