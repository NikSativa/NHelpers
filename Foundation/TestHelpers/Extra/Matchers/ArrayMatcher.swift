import Foundation
import Nimble

public func beUnified<T: Equatable>() -> Predicate<[T]> {
    return beUnified(where: ==)
}

public func beUnified<T>(where closure: @escaping (T, T) -> Bool) -> Predicate<[T]> {
    return Predicate.define("be unified") { actualExpression, _ in
        guard let actualValue = try actualExpression.evaluate() else {
            return PredicateResult(bool: false, message: .expectedTo("not be nil"))
        }

        guard !actualValue.isEmpty else {
            return PredicateResult(bool: false, message: .expectedTo("not be empty"))
        }

        let filtered = actualValue.enumerated()
            .map { index, t1 in
                return (index, actualValue.reduce(0) { r, t2 in r + (closure(t1, t2) ? 1 : 0) })
            }
            .compactMap {
                return $0.1 != 1 ? $0.0 : nil
            }

        return PredicateResult(bool: filtered.isEmpty, message: .expectedTo("be unified, but contains duplicates at indexes: \(filtered)"))
    }
}

public func equal<T: Equatable>(_ expectedValue: [T]?) -> Predicate<[T]> {
    return equal(expectedValue, where: ==)
}

public func equal<T>(_ expectedValue: [T]?, where closure: @escaping (T, T) -> Bool) -> Predicate<[T]> {
    return Predicate.define("be equal") { actualExpression, failureMessage in
        let actualExpression = try actualExpression.evaluate()
        if actualExpression == nil, expectedValue == nil {
            return PredicateResult(bool: true, message: failureMessage)
        }

        guard let actualValue = actualExpression else {
            return PredicateResult(bool: false, message: .expectedActualValueTo("not be nil"))
        }

        guard let expectedValue = expectedValue else {
            return PredicateResult(bool: false, message: .expectedTo("not be nil"))
        }

        guard expectedValue.count == actualValue.count else {
            return PredicateResult(bool: false, message: .expectedTo("have the same sizes (actual: expected) => (\(actualValue.count): \(expectedValue.count))"))
        }

        let filtered = zip(actualValue, expectedValue).enumerated().compactMap { index, t in
            return closure(t.0, t.1) ? nil : index
        }

        return PredicateResult(bool: filtered.isEmpty, message: .expectedTo("be equal, but contains differences at indexes: \(filtered)"))
    }
}
