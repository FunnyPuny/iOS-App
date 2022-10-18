// AppDelegate.swift
// Created by Zlata Guseva on 12.10.2022.

import RealmSwift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupRealm()
        setupRootViewController()
        return true
    }

    private func setupRealm() {
        do {
            let realm = try Realm()
            print("Realm is located at:", realm.configuration.fileURL!)
        } catch {
            print("Error initialasing realm with \(error)")
        }
    }

    private func setupRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
    }
}
