// GIFs.swift
// FunnyPuny. Created by Zlata Guseva.

import UIKit

extension UIImageView {
    static let chillStateGIF: UIImageView = {
        do {
            let gif = try UIImage(gifName: "chillState.gif")
            let imageView = UIImageView(gifImage: gif)
            return imageView
        } catch {
            print(error)
        }
        return UIImageView()
    }()

    static let emptyStateGIF: UIImageView = {
        do {
            let gif = try UIImage(gifName: "emptyState.gif")
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
