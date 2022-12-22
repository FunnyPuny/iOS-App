// ProgressView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class ProgressView: UIView {
    var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = Colors.textPrimary.color
        label.textAlignment = .center
        label.font = .medium14
        return label
    }()

    private var progressLayer = CAShapeLayer()
    private var trackLayer = CAShapeLayer()

    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }

    var trackColor = UIColor.white {
        didSet {
            trackLayer.strokeColor = trackColor.cgColor
        }
    }

    private var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        makeConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupStyle()
        makeConstraints()
    }

    private func setupStyle() {
        backgroundColor = .clear
        layer.cornerRadius = frame.size.width / 2
        let circlePath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
            radius: (frame.size.width - 1.5) / 2,
            startAngle: CGFloat(-0.5 * .pi), endAngle: CGFloat(1.5 * .pi),
            clockwise: true
        )
        trackLayer.path = circlePath.cgPath
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 5.0
        trackLayer.strokeEnd = 1.0
        layer.addSublayer(trackLayer)

        progressLayer.path = circlePath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = progressColor.cgColor
        progressLayer.lineWidth = 5.0
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = progress
        progressLayer.strokeStart = 0
        layer.addSublayer(progressLayer)
        layer.transform = CATransform3DMakeRotation(CGFloat(90 * Double.pi / 180), 0, 0, 0)

        addSubview(statusLabel)
    }

    private func makeConstraints() {
        statusLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(1)
            make.centerX.equalToSuperview().offset(1)
        }
    }

    func progressAnimation(duration: TimeInterval = 1, value: Float) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = value
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")

        statusLabel.fadeIn()
    }
}
