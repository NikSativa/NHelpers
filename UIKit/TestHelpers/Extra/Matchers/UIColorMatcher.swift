import Nimble
import NSpry
import NUIKitTestHelpers
import UIKit

@testable import NFoundationExtraTestHelpers

public func equal<T: UIColor>(light: T?, dark: T?) -> Nimble.Predicate<T> {
    return equal(T.colorWith(dynamicProvider: { style in
        switch style {
        case .dark:
            return dark ?? .init()
        case .light:
            return light ?? .init()
        }
    }))
}

public func equal<T: UIColor>(_ expectedValue: T?) -> Predicate<T> {
    return Predicate.define("be equal") { actualExpression, _ in
        let actualExpression = try actualExpression.evaluate()
        return equal(actualExpression, expectedValue)
    }
}

public func equal<T: UIColor>(_ expectedValue: [T]?) -> Predicate<[T]> {
    return equal(expectedValue) { a, b in
        isEqual(a, b)
    }
}

private func equal(_ lhs: UIColor, _ rhs: UIColor) -> Bool {
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

private func equal(_ lhs: UIColor?, _ rhs: UIColor?) -> PredicateResult {
    if lhs == nil, rhs == nil {
        return PredicateResult(status: .matches, message: .expectedTo("be equal"))
    }

    guard let actualValue = lhs else {
        return PredicateResult(status: .fail, message: .expectedActualValueTo("not be nil"))
    }

    guard let expectedValue = rhs else {
        return PredicateResult(status: .fail, message: .expectedTo("not be nil"))
    }

    let dark = equal(actualValue.real(.dark), expectedValue.real(.dark))
    let light = equal(actualValue.real(.light), expectedValue.real(.light))

    let expectedText = [
        "equals",
        light ? nil : "light colors <\(actualValue.real(.light).testDescription + "&" + expectedValue.real(.light).testDescription)>",
        dark ? nil : "dark colors <\(actualValue.real(.dark).testDescription + "&" + expectedValue.real(.dark).testDescription)>"
    ]
    return PredicateResult(bool: dark && light, message: .expectedTo(expectedText.compactMap { $0 }.joined(separator: " ")))
}
