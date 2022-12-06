// EverydayView.swift
// FunnyPuny. Created by Zlata Guseva.

import Foundation
import UIKit

protocol EverydayViewProtocolDelegate: AnyObject {
    func didSelect(index: Int?)
}

class EverydayView: UIView {
    var index: Int?
    var everydayLabel: String
    var isSelected: Bool
    weak var delegate: EverydayViewProtocolDelegate?

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = everydayLabel
        label.font = .regular17
        label.textAlignment = .center
        return label
    }()

    required init(_ everydayLabel: String, isSelected: Bool) {
        self.everydayLabel = everydayLabel
        self.isSelected = isSelected
        super.init(frame: .zero)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubviews()
        layer.cornerRadius = 6
        isUserInteractionEnabled = true
        let gesture = UIGestureRecognizer(target: self, action: #selector(onTap))
        addGestureRecognizer(gesture)
        setupStyle()
        makeConstraints()
        // addTap()
    }

    @objc
    func onTap() {
        isSelected.toggle()
        setupStyle()
        delegate?.didSelect(index: index ?? 0)
    }

    private func addSubviews() {
        addSubview(label)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }

    func setupStyle() {
        backgroundColor = isSelected ? Colors.backgroundAccent.color : Colors.backgroundIsland.color
        label.textColor = isSelected ? Colors.textButton.color : Colors.textPrimary.color
    }

    private func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(daySelected))
        addGestureRecognizer(tap)
    }

    @objc
    func daySelected() {
        isSelected.toggle()
        setupStyle()
    }
}
