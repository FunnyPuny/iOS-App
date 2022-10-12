//
//  TabBarController.swift
//  FunnyPuny-iOSApp
//
//  Created by Zlata Guseva on 12/10/2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupStyleTabBar()
        setupTabBarItems()
    }

    func setupStyleTabBar() {
        tabBar.tintColor = .primaryText
        tabBar.barTintColor = .white
    }

    func setupTabBarItems() {
        let firstViewController = HomeViewController()
        firstViewController.tabBarItem = UITabBarItem(
            title: "Add",
            image: .add,
            tag: 0
        )
        
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(
            title: "Profile",
            image: .init(systemName: "book.closed"),
            tag: 1
        )

        viewControllers = [firstViewController, secondViewController]
    }

}
