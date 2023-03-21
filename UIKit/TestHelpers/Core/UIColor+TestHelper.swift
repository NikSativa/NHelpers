import Foundation
import NSpry
import UIKit

@testable import NUIKit

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

public func isEqual(_ lhs: UIColor?, _ rhs: UIColor?) -> Bool {
    if lhs == nil, rhs == nil {
        return true
    }

    guard let lhs, let rhs else {
        return false
    }

    let actualComponents = lhs.components.rgba
    let expectedComponents = rhs.components.rgba

    func closeTo(_ a: CGFloat, _ b: CGFloat) -> Bool {
        return Int(a * 255) == Int(b * 255)
    }

    return closeTo(expectedComponents.r, actualComponents.r)
        && closeTo(expectedComponents.g, actualComponents.g)
        && closeTo(expectedComponents.b, actualComponents.b)
        && closeTo(expectedComponents.a, actualComponents.a)
}
