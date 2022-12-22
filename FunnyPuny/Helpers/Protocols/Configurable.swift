// Configurable.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

/// Определяет возможность настройки представления
protocol Configurable where Self: UIView {
    associatedtype ViewModel

    /// Настраивает отображение
    ///
    /// - Parameter viewModel: Модель представления для конфигурации
    func configure(with viewModel: ViewModel)
}
