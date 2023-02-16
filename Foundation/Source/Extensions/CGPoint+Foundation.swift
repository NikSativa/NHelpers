import CoreGraphics
import Foundation
import UIKit

public prefix func -(v: CGPoint) -> CGPoint {
    return CGPoint(x: -v.x, y: -v.y)
}

// MARK: a ? b

public func +(a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x + b.x, y: a.y + b.y)
}

public func -(a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x - b.x, y: a.y - b.y)
}

public func *(a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x * b.x, y: a.y * b.y)
}

public func /(a: CGPoint, b: CGPoint) -> CGPoint {
    return CGPoint(x: a.x / b.x, y: a.y / b.y)
}

// MARK: a ?= b

// swiftlint:disable shorthand_operator
public func +=(a: inout CGPoint, b: CGPoint) {
    a = a + b
}

public func -=(a: inout CGPoint, b: CGPoint) {
    a = a - b
}

public func *=(a: inout CGPoint, b: CGPoint) {
    a = a * b
}

public func /=(a: inout CGPoint, b: CGPoint) {
    a = a / b
}

// MARK: a ?= float

public func *=(a: inout CGPoint, b: CGFloat) {
    a = a * b
}

public func /=(a: inout CGPoint, b: CGFloat) {
    a = a / b
}

// swiftlint:enable shorthand_operator

// MARK: float * point

public func *(a: CGPoint, b: CGFloat) -> CGPoint {
    return CGPoint(x: a.x * b, y: a.y * b)
}

public func *(a: CGFloat, b: CGPoint) -> CGPoint {
    return b * a
}

// MARK: point / float

public func /(a: CGPoint, b: CGFloat) -> CGPoint {
    return CGPoint(x: a.x / b, y: a.y / b)
}

public func /(a: CGFloat, b: CGPoint) -> CGPoint {
    return b / a
}

// MARK: ext

public extension CGPoint {
    var length: CGFloat {
        return sqrt(lengthSquared)
    }

    var lengthSquared: CGFloat {
        return x * x + y * y
    }

    var normal: CGPoint {
        let l = length
        return l > 0 ? self / l : self
    }

    var size: CGSize {
        return CGSize(width: x, height: y)
    }

    /// Given an angle in radians, creates a vector of length 1.0 and returns the
    /// result as a new CGPoint. An angle of 0 is assumed to point to the right.
    init(angle: CGFloat) {
        self.init(x: cos(angle), y: sin(angle))
    }

    /// Calculates the distance between two CGPoints. Pythagoras!
    func distance(to: CGPoint) -> CGFloat {
        return (self - to).length
    }

    /// Returns the angle in radians of the vector described by the CGPoint.
    /// The range of the angle is -π to π; an angle of 0 points to the right.
    var angle: CGFloat {
        return atan2(y, x)
    }
}
