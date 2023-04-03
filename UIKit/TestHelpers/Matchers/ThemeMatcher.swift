// import Foundation
//
// import NUIKit
// import NUIKitTestHelpers
//
// public func beAppliedTo<T: StylePropertyTestable>(_ expectedValue: T.ViewType?) -> Predicate<ViewStyle<T>> {
//    return Predicate.define("be applied to") { actualExpression, _ in
//        let newFailureMessage = ExpectationMessage.expectedActualValueTo("equal <\(String(describing: expectedValue))>")
//        guard let expectedValue else {
//            return PredicateResult(bool: false, message: .expectedCustomValueTo("have a \(T.ViewType.self)", actual: "nil"))
//        }
//
//        if let actualValue = try actualExpression.evaluate() {
//            return PredicateResult(bool: actualValue.isApplied(to: expectedValue), message: newFailureMessage)
//        }
//
//        return PredicateResult(bool: false, message: newFailureMessage)
//    }
// }
