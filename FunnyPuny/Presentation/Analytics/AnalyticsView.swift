// AnalyticsView.swift
// FunnyPuny. Created by Zlata Guseva.

import SnapKit
import UIKit

class AnalyticsView: UIView {
    var commonAnalyticsView: UIView = {
        let view = UIView()
        view.backgroundColor = .vividPink
        return view
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
        setupStyle()
        addSubviews()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .background
    }

    private func addSubviews() {
        addSubview(commonAnalyticsView)
    }

    private func makeConstraints() {
        commonAnalyticsView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(113)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
    }
}
