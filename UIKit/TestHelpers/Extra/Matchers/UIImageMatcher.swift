import Foundation
import Nimble
import UIKit

@testable import NFoundationExtraTestHelpers
@testable import NUIKitTestHelpers

public func equal<T: UIImage>(_ expectedValue: T?) -> Predicate<T> {
    return Predicate.define("be equal") { actualExpression, _ in
        let actualExpression = try actualExpression.evaluate()
        return equal(actualExpression, expectedValue)
    }
}

public func equal<T: UIImage>(_ expectedValue: [T]?) -> Predicate<[T]> {
    return equal(expectedValue) { a, b in
        isEqual(a, b)
    }
}

private func equal(_ lhs: UIImage?, _ rhs: UIImage?) -> PredicateResult {
    if lhs == nil, rhs == nil {
        return PredicateResult(status: .matches, message: .expectedTo("be equal"))
    }

    guard let actualValue = lhs else {
        return PredicateResult(status: .fail, message: .expectedActualValueTo("not be nil"))
    }

    guard let expectedValue = rhs else {
        return PredicateResult(status: .fail, message: .expectedTo("not be nil"))
    }

    guard expectedValue.size == actualValue.size else {
        return PredicateResult(status: .doesNotMatch, message: .expectedTo("have the same sizes"))
    }

    return PredicateResult(bool: actualValue.pngData() == expectedValue.pngData(), message: .expectedTo("be equal"))
}

public func ==(lhs: SyncExpectation<UIImage>, rhs: UIImage?) {
    lhs.to(equal(rhs))
}

public func !=(lhs: SyncExpectation<UIImage>, rhs: UIImage?) {
    lhs.toNot(equal(rhs))
}
