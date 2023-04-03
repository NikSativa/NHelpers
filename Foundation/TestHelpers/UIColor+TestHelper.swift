import Foundation
import NFoundation
import NSpry
import UIKit

public extension UIColor {
    func real(_ style: Style) -> UIColor {
        if #available(iOS 13, *) {
            let userInterfaceStyle: UIUserInterfaceStyle
            switch style {
            case .dark:
                userInterfaceStyle = .dark
            case .light:
                userInterfaceStyle = .light
            }
            let traitCollection = UITraitCollection(userInterfaceStyle: userInterfaceStyle)
            return resolvedColor(with: traitCollection)
        }

        return self
    }
}

extension UIColor.Style: SpryEquatable {}
