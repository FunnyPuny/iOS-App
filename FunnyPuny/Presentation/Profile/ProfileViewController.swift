// ProfileViewController.swift
// FunnyPuny. Created by Zlata Guseva.

import SwiftDate
import UIKit

class ProfileViewController: ViewController {
    private var profileView = ProfileView()
    private var profileCellTypes = ProfileCellType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Texts.profile
        view = profileView
        setupTableView()
    }

    private func setupTableView() {
        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
    }
}

// MARK: UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let viewController = NavigationController(rootViewController: NotificationsViewController())
            viewController.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(viewController, animated: true)
            present(viewController, animated: true)
        }
    }
}

// MARK: UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        profileCellTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: ProfileCell.self)
        let cellType = profileCellTypes[indexPath.row]
        let profileCellViewModel = ProfileCellViewModel(itemName: cellType.name, isAvailable: cellType.isAvailable)
        cell.configure(with: profileCellViewModel)
        return cell
    }
}
