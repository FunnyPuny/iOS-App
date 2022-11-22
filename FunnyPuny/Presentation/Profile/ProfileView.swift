// ProfileView.swift
// FunnyPuny. Created by Zlata Guseva.

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
        backgroundColor = .backgroundGlobe
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
