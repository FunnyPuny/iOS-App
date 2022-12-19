// ViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import RealmSwift
import UIKit

class ViewController: UIViewController {
    // swiftlint:disable force_try
    let realm = try! Realm()
    // swiftlint:enable force_try

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundGlobe.color
    }
}
