// MenuButtonView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

protocol MenuButtonViewDelegate: AnyObject {
    func menuButtonDidPressed(title: String)
}

class MenuButtonView: UIView {
    var delegate: MenuButtonViewDelegate?

    var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .textAccent
        label.font = .bold24
        label.text = Texts.allHabits
        return label
    }()

    private var pointerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .down
        imageView.backgroundColor = .backgroundGlobe
        imageView.tintColor = .iconsActive
        return imageView
    }()

    private var button = UIButton()

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
        backgroundColor = .backgroundGlobe
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
            UIAction(title: $0, handler: { action in
                self.delegate?.menuButtonDidPressed(title: action.title)
            })
        }
        button.menu = UIMenu(children: actions)
        button.showsMenuAsPrimaryAction = true
    }
}
