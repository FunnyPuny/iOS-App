// ProfileViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class ProfileViewController: ViewController {
    private var profileView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.profile
        view = profileView
    }
}
