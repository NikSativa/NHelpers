import CoreGraphics
import Foundation

// MARK: a ? b

public func +(a: CGSize, b: CGSize) -> CGSize {
    return CGSize(width: a.width + b.width, height: a.height + b.height)
}

public func -(a: CGSize, b: CGSize) -> CGSize {
    return CGSize(width: a.width - b.width, height: a.height - b.height)
}

public func *(a: CGSize, b: CGSize) -> CGSize {
    return CGSize(width: a.width * b.width, height: a.height * b.height)
}

public func /(a: CGSize, b: CGSize) -> CGSize {
    return CGSize(width: a.width / b.width, height: a.height / b.height)
}

// MARK: a ?= b

// swiftlint:disable shorthand_operator
public func +=(a: inout CGSize, b: CGSize) {
    a = a + b
}

public func -=(a: inout CGSize, b: CGSize) {
    a = a - b
}

public func *=(a: inout CGSize, b: CGSize) {
    a = a * b
}

public func /=(a: inout CGSize, b: CGSize) {
    a = a / b
}

// swiftlint:enable shorthand_operator

// MARK: float * size

public func *(a: CGSize, b: CGFloat) -> CGSize {
    return CGSize(width: a.width * b, height: a.height * b)
}

public func *(a: CGFloat, b: CGSize) -> CGSize {
    return b * a
}

// MARK: float / size

public func /(a: CGSize, b: CGFloat) -> CGSize {
    return CGSize(width: a.width / b, height: a.height / b)
}

public func /(a: CGFloat, b: CGSize) -> CGSize {
    return b / a
}

// MARK: a ?= b

// swiftlint:disable shorthand_operator
public func *=(a: inout CGSize, b: CGFloat) {
    a = a * b
}

public func /=(a: inout CGSize, b: CGFloat) {
    a = a / b
}

// swiftlint:enable shorthand_operator

public extension CGSize {
    var point: CGPoint { return CGPoint(x: width, y: height) }
    var rect: CGRect { return CGRect(x: 0, y: 0, width: width, height: height) }
    var minimum: CGFloat { return min(width, height) }
    var maximum: CGFloat { return max(width, height) }

    func fitted(_ content: CGSize) -> CGSize {
        if content.equalTo(CGSize.zero) || equalTo(CGSize.zero) {
            return CGSize.zero
        }

        let containerRatio = width / height
        let contentRatio = content.width / content.height

        return CGSize(width: containerRatio <= contentRatio ? width : height * contentRatio,
                      height: containerRatio >= contentRatio ? height : width / contentRatio)
    }
}
