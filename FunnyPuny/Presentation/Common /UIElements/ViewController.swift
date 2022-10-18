// ViewController.swift
// Created by Zlata Guseva on 14.10.2022.

import RealmSwift
import UIKit

class ViewController: UIViewController {
    // swiftlint:disable all
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .background
    }
}
