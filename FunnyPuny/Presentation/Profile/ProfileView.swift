// ProfileView.swift
// Created by Zlata Guseva on 13.10.2022.

import SwiftyGif
import UIKit

class ProfileView: UIView {
    private var gifImageView: UIImageView = .profileGIF

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
        addSubview(gifImageView)
    }

    private func makeConstraints() {
        gifImageView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.center.equalTo(self)
        }
    }
}
