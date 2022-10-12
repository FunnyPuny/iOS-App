//
//  HomeView.swift
//  FunnyPuny-iOSApp
//
//  Created by Zlata Guseva on 12/10/2022.
//

import UIKit
import SwiftyGif

class HomeView: UIView {
    
    // MARK: - UI elements
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to FunnyPuny!"
        label.textColor = .primaryText
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    lazy var gifImageView: UIImageView = {
        do {
            let gif = try UIImage(gifName: "test.gif")
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
    
    required init?(coder aDecoder: NSCoder) {
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
