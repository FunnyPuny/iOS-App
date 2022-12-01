// HomeViewState.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class HomeViewState: UIView {
    var titleText: String
    var labelText: String
    var gifImageView: UIImageView

    lazy var title: UILabel = {
        let title = UILabel()
        title.text = titleText
        title.textColor = Colors.textPrimary.color
        title.font = .regular17
        return title
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = labelText
        title.textColor = Colors.textPrimary.color
        title.font = .regular17
        return label
    }()

    required init(titleText: String, labelText: String, gifImageView: UIImageView) {
        self.titleText = titleText
        self.labelText = labelText
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
        addSubview(title)
        addSubview(label)
    }

    private func makeConstraints() {
        gifImageView.snp.makeConstraints { make in
            make.size.equalTo(200)
            make.centerX.equalToSuperview()
        }

        title.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(gifImageView.snp.bottom).offset(24)
            make.height.equalTo(20)
        }

        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(8)
            make.height.equalTo(24)
        }
    }
}
