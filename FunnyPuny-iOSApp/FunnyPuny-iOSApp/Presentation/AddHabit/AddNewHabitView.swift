// AddNewHabitView.swift
// Created by Zlata Guseva on 13.10.2022.

import UIKit

class AddNewHabitView: UIView {
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Add your first Habit!"
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        makeConstraints()
        setupStyle()
    }

    private func setupStyle() {
        backgroundColor = .white
    }

    private func addSubviews() {
        addSubview(mainLabel)
    }

    private func makeConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(64)
        }
    }
}
