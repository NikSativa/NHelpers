import Foundation
import UIKit

public struct BaseColorProvider<Kind: ColorRepresentable>: ColorProviding {
    public init() {}

    public func color(_ kind: Kind) -> UIColor {
        return .colorWith { style in
            switch style {
            case .light:
                return kind.colorConfiguration.lightColor
            case .dark:
                return kind.colorConfiguration.darkColor
            }
        }
    }
}

private extension ColorConfig {
    var lightColor: UIColor {
        return hexWithAlpha ? .init(hexWithAlpha: light) : .init(hex: light, alpha: alpha)
    }

    var darkColor: UIColor {
        let hex = dark ?? light
        return hexWithAlpha ? .init(hexWithAlpha: hex) : .init(hex: hex, alpha: alpha)
    }
}
