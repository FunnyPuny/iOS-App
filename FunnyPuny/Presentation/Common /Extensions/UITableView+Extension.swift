// UITableView+Extension.swift
// Created by Zlata Guseva on 18.10.2022.

import UIKit

extension UITableView {
    ///  Dequeue reusable UITableViewCell using class name.
    /// - Parameter name: UITableViewCell type.
    /// - Returns: UITableViewCell object with associated class name.
    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name)) as? T else {
            fatalError("Couldn't find \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    func cellForRow<T: UITableViewCell>(at indexPath: IndexPath, withClass name: T.Type) -> T {
        guard let cell = cellForRow(at: indexPath) as? T else {
            fatalError("Couldn't find \(String(describing: name)), make sure the cell is registered with table view")
        }
        return cell
    }

    /// Register UITableViewCell using class name.
    /// - Parameter name: UITableViewCell type.
    func register<T: UITableViewCell>(cellWithClass name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
}
