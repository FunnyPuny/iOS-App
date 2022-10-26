// CalendarHeaderView.swift
// Created by Zlata Guseva on 19.10.2022.

import JTAppleCalendar
import SnapKit
import UIKit

class CalendarHeaderView: UIView {
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainText
        label.font = .init(name: "SF-Pro-Italic", size: 48)
        label.textAlignment = .center
        // TODO:
        label.text = Date().string(dateFormat: .formatMMMMd)
        return label
    }()

    var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .separator
        return view
    }()

    var pointerView: UIView = {
        var view = UIView()
        // Creating triangle
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -6, y: 0))
        path.addLine(to: CGPoint(x: 6, y: 0))
        path.addLine(to: CGPoint(x: 0, y: 12))
        path.addLine(to: CGPoint(x: -6, y: 0))
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.mainText?.cgColor
        shapeLayer.lineWidth = 3
        view.layer.addSublayer(shapeLayer)
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
        addSubviews()
        makeConstraints()
    }

    private func addSubviews() {
        addSubview(dateLabel)
        addSubview(separatorView)
        addSubview(pointerView)
    }

    private func makeConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        separatorView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.height.equalTo(1)
        }

        pointerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(8)
            make.top.equalTo(separatorView.snp.bottom)
        }
    }
}
