// GIFs.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UIImageView {
    static let homeGIF: UIImageView = {
        do {
            let gif = try UIImage(gifName: "home.gif")
            let imageView = UIImageView(gifImage: gif)
            return imageView
        } catch {
            print(error)
        }
        return UIImageView()
    }()

    static let profileGIF: UIImageView = {
        do {
            let gif = try UIImage(gifName: "profile.gif")
            let imageView = UIImageView(gifImage: gif)
            return imageView
        } catch {
            print(error)
        }
        return UIImageView()
    }()
}
