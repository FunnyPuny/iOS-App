// UIViewController+Extension.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UIViewController {
    func addHapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
}
