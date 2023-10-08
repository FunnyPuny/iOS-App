// AppDelegate.swift
// FunnyPuny. Created by Zlata Guseva.

import FirebaseCore
import RealmSwift
import SwiftDate
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
        SwiftDate.defaultRegion = .local
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
