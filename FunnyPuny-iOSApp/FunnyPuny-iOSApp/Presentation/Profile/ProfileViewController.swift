// ProfileViewController.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class ProfileViewController: ViewController {
    private var profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        view = profileView
    }
}
