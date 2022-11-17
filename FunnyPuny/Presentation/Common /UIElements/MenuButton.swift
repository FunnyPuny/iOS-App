// MenuButton.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class MenuButtonView: UIView {
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .vividPink
        label.font = .bold24
        label.text = Texts.allHabits
        return label
    }()

    var pointerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .down
        imageView.backgroundColor = .background
        imageView.tintColor = .vividPink
        return imageView
    }()

    var button = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .background
    }

    private func addSubviews() {
        addSubview(categoryLabel)
        addSubview(pointerImageView)
        addSubview(button)
    }

    private func makeConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }

        pointerImageView.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(4)
            make.centerY.equalToSuperview()
            make.size.equalTo(16)
        }

        button.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func makeMenu(with array: [String]) {
        let actions = array.map {
            UIAction(title: $0, handler: { _ in })
        }
        button.menu = UIMenu(title: "Choose habit", children: actions)
        button.showsMenuAsPrimaryAction = true
    }
}
