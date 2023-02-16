import Foundation
import NFoundation
import Nimble

public func equal<K: Hashable, T: Equatable>(_ expectedValue: [K: T]?) -> Predicate<[K: T]> {
    return equal(expectedValue, where: ==)
}

public func equal<K: Hashable, T>(_ expectedValue: [K: T]?, where closure: @escaping (T, T) -> Bool) -> Predicate<[K: T]> {
    return equal(expectedValue, where: { _, a, b in
        return closure(a, b)
    })
}

public func equal<K: Hashable, T>(_ expectedValue: [K: T]?, where closure: @escaping (K, T, T) -> Bool) -> Predicate<[K: T]> {
    return Predicate.define("be equal") { actualExpression, _ in
        let actualExpression = try actualExpression.evaluate()
        if actualExpression == nil, expectedValue == nil {
            return PredicateResult(bool: true, message: .expectedTo("not be nil"))
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

        var filteredKeys: [K] = []
        var filteredValues: [(K, T, T)] = []
        for (key, a) in actualValue {
            if let b = expectedValue[key] {
                if !closure(key, a, b) {
                    filteredValues += (key, a, b)
                }
            } else {
                filteredKeys += key
            }
        }

        let filteredStrings = filteredValues.map { "\($0): (\($1): \($2))" }
        return PredicateResult(bool: filteredKeys.isEmpty && filteredValues.isEmpty,
                               message: .expectedTo("be equal, but contains differences for keys: \(filteredKeys), values: \(filteredStrings)"))
    }
}
