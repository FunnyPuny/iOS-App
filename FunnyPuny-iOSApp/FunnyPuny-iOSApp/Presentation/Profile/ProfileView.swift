// ProfileView.swift
// Created by Zlata Guseva on 13.10.2022.

import SwiftyGif
import UIKit

class ProfileView: UIView {
    // MARK: - UI elements

    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()

    lazy var gifImageView: UIImageView = {
        do {
            let gif = try UIImage(gifName: "profile.gif")
            let imageView = UIImageView(gifImage: gif)
            return imageView
        } catch {
            print(error)
        }
        return UIImageView()
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
        addSubview(gifImageView)
        addSubview(mainLabel)
    }

    private func makeConstraints() {
        gifImageView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.center.equalTo(self)
        }

        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(64)
        }
    }
}
