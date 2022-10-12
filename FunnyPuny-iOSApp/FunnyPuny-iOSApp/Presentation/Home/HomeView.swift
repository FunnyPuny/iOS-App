//
//  HomeView.swift
//  FunnyPuny-iOSApp
//
//  Created by Zlata Guseva on 12/10/2022.
//

import UIKit

class HomeView: UIView {
    
    // MARK: - UI elements
    
    lazy var boxView: UIView = {
        let view = UIView()
        view.backgroundColor = .purple
        return view
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
        addSubview(boxView)
    }
    
    private func makeConstraints() {
        boxView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.center.equalTo(self)
        }
    }
    
}
