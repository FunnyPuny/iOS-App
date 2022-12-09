// HomeViewState.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class HomeViewState: UIView {
    var primaryText: String
    var secondaryText: String
    var gifImageView: UIImageView

    lazy var primaryLabel: UILabel = {
        let label = UILabel()
        label.text = primaryText
        label.textColor = Colors.textPrimary.color
        label.font = .bodyRegular
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    lazy var secondaryLabel: UILabel = {
        let label = UILabel()
        label.text = secondaryText
        label.textColor = Colors.textPrimary.color
        label.font = .bodyRegular
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    required init(titleText: String, labelText: String, gifImageView: UIImageView) {
        primaryText = titleText
        secondaryText = labelText
        self.gifImageView = gifImageView
        super.init(frame: .zero)
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
        backgroundColor = Colors.backgroundGlobe.color
    }

    private func addSubviews() {
        addSubview(gifImageView)
        addSubview(primaryLabel)
        addSubview(secondaryLabel)
    }

    private func makeConstraints() {
        gifImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalToSuperview()
        }

        primaryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(gifImageView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(32)
        }

        secondaryLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(primaryLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(32)
        }
    }
}
