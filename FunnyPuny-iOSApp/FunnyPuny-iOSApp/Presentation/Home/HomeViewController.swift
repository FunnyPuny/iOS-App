//
//  HomeViewController.swift
//  FunnyPuny-iOSApp
//
//  Created by Zlata Guseva on 30/09/2022.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    lazy var homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = homeView
    }
    
}
