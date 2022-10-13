// ProfileViewController.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class ProfileViewController: UIViewController {
    var profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = profileView
        view.backgroundColor = .mainBackGround
    }
}
