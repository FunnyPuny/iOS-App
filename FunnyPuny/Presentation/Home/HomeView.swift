// HomeView.swift
// Created by Zlata Guseva on 12.10.2022.

import SwiftyGif
import UIKit

class HomeView: UIView {
    private var mainLabel: UILabel = {
        let label = UILabel()
        label.text = Texts.welcome
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    private var gifImageView: UIImageView = .homeGIF
    
    private var dateLabel: UILabel = {
        let label = UILabel()
        let date = Date()
        let dateFormatStyle = DateFormatter()
        dateFormatStyle.dateFormat = Texts.dateFormat
        label.text = dateFormatStyle.string(from: date)
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

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
    }

    private func addSubviews() {
        addSubview(gifImageView)
        addSubview(mainLabel)
        addSubview(dateLabel)
    }

    private func makeConstraints() {
        gifImageView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.center.equalTo(self)
        }

        dateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(160)
        }

        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(dateLabel.snp.bottom).offset(64)
        }
    }
}
