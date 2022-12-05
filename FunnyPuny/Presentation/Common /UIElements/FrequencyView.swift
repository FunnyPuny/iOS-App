// FrequencyView.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

class FrequencyView: UIView {
    var viewState: ViewState

    lazy var label: UILabel = {
        let label = UILabel()
        label.text = Texts.frequency
        label.textColor = Colors.textPrimary.color
        label.font = .regular20
        return label
    }()

    lazy var everydayLabel = EverydayView(Texts.everyday, isSelected: true)

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews(Frequency.allCases.map { DayView($0) })
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()

    required init(viewState: ViewState = .everyday) {
        self.viewState = viewState
        super.init(frame: .zero)
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
        addSubview(label)
        addSubview(everydayLabel)
        addSubview(stackView)
    }

    private func makeConstraints() {
        label.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(32)
        }

        everydayLabel.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(12)
            make.leading.equalToSuperview()
            make.height.greaterThanOrEqualTo(32)
            make.width.equalTo(92)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalTo(everydayLabel.snp.bottom).offset(12)
            make.height.greaterThanOrEqualTo(32)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
