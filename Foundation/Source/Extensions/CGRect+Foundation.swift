import CoreGraphics
import Foundation

// MARK: a ? b

public func +(a: CGRect, b: CGRect) -> CGRect {
    return CGRect(x: a.origin.x + b.origin.x, y: a.origin.y + b.origin.y, width: a.size.width + b.size.width, height: a.size.height + b.size.height)
}

public func -(a: CGRect, b: CGRect) -> CGRect {
    return CGRect(x: a.origin.x - b.origin.x, y: a.origin.y - b.origin.y, width: a.size.width - b.size.width, height: a.size.height - b.size.height)
}

public func *(a: CGRect, b: CGRect) -> CGRect {
    return CGRect(x: a.origin.x * b.origin.x, y: a.origin.y * b.origin.y, width: a.size.width * b.size.width, height: a.size.height * b.size.height)
}

public func /(a: CGRect, b: CGRect) -> CGRect {
    return CGRect(x: a.origin.x / b.origin.x, y: a.origin.y / b.origin.y, width: a.size.width / b.size.width, height: a.size.height / b.size.height)
}

// MARK: a ?= b

// swiftlint:disable shorthand_operator
public func +=(a: inout CGRect, b: CGRect) {
    a = a + b
}

public func -=(a: inout CGRect, b: CGRect) {
    a = a - b
}

public func *=(a: inout CGRect, b: CGRect) {
    a = a * b
}

public func /=(a: inout CGRect, b: CGRect) {
    a = a / b
}

// swiftlint:enable shorthand_operator

public extension CGRect {
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }

    func centered(_ content: CGSize) -> CGRect {
        return CGRect(x: origin.x + (size.width - content.width) / 2,
                      y: origin.y + (size.height - content.height) / 2,
                      width: content.width,
                      height: content.height)
    }

    func fittedCentered(_ content: CGSize) -> CGRect {
        return centered(size.fitted(content))
    }

    internal func increase(by percentage: CGFloat) -> CGRect {
        let mult = percentage / 2
        return insetBy(dx: -width * mult, dy: -height * mult)
    }
}
