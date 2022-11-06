// UIView+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

//
//  UIView + Extension.swift
//  FunnyPuny
//
//  Created by Злата Гусева on 05.11.2022.
//
import UIKit

extension UIView {
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .zero
        layer.shadowRadius = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
