import Foundation
import UIKit

public struct ColorConfig: ExpressibleByIntegerLiteral {
    public let light: UInt
    public let dark: UInt?
    public let hexWithAlpha: Bool
    public let alpha: CGFloat

    public init(light: UInt,
                dark: UInt? = nil,
                hexWithAlpha: Bool = false,
                alpha: CGFloat = 1.0) {
        self.light = light
        self.dark = dark
        self.hexWithAlpha = hexWithAlpha
        self.alpha = alpha
    }

    public init(integerLiteral value: UInt) {
        self.init(light: value)
    }
}
