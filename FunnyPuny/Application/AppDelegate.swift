// AppDelegate.swift
// FunnyPuny. Created by Zlata Guseva.

import FirebaseCore
import RealmSwift
import SwiftDate
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let notificationCenter = UNUserNotificationCenter.current()

    func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        notificationCenter.requestAuthorization(options: options) {
            didAllow, error in
            if !didAllow {
                print("User has declined notifications")
            }
        }
        notificationCenter.delegate = self
        FirebaseApp.configure()
        SwiftDate.defaultRegion = .local
        setupRealm()
        setupRootViewController()
        return true
    }

    private func setupRealm() {
        let config = Realm.Configuration(
            schemaVersion: 2)
        Realm.Configuration.defaultConfiguration = config
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

// MARK: Notifications

extension AppDelegate {
    func getRequest() {}

    func scheduleNotification(notificationType: String) {
        let content = UNMutableNotificationContent()
        content.title = notificationType
        content.body = "This is example how to create " + notificationType
        content.sound = UNNotificationSound.default
        content.badge = 1

        let date = Date(timeIntervalSinceNow: 3600)
        let triggerDaily = Calendar.current.dateComponents([.hour, .minute, .second,], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let identifier = "Local Notification"
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        notificationCenter.add(request) { error in
            if let error {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void)
    {
        completionHandler([.alert, .sound])
    }
}
