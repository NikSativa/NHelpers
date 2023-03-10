import Foundation

public class TextValidator: Equatable, ExpressibleByArrayLiteral {
    public typealias Eventier = (TextValidator, TextValidationResult) -> Void
    private var eventier: Eventier?

    private let validators: [TextValidatable]

    public required init(arrayLiteral elements: TextValidatable...) {
        self.validators = elements
    }

    public required init(_ validatables: [TextValidatable]) {
        self.validators = validatables
    }

    public convenience init(_ validator: TextValidatable) {
        self.init([validator])
    }

    public convenience init(validators: [TextValidator]) {
        let validatables = validators.reduce([]) { $0 + $1.validators }
        self.init(validatables)
    }

    public func isTextValid(_ text: String) -> TextValidationResult {
        let result: TextValidationResult = validators
            .first(where: {
                !$0.isValid(string: text)
            })
            .map {
                $0.errorText.map { .invalidWithErrorText($0) } ?? .invalid
            } ?? .valid

        eventier?(self, result)
        return result
    }

    public static func +(lhs: TextValidator, rhs: TextValidatable) -> TextValidator {
        let combinedValidations = lhs.validators + [rhs]
        return .init(combinedValidations)
    }

    public static func +(lhs: TextValidatable, rhs: TextValidator) -> TextValidator {
        let combinedValidations = [lhs] + rhs.validators
        return .init(combinedValidations)
    }

    public static func +(lhs: TextValidator, rhs: TextValidator) -> TextValidator {
        let validators = lhs.validators + rhs.validators
        return .init(validators)
    }

    public static func ==(lhs: TextValidator, rhs: TextValidator) -> Bool {
        let lhsIDs = Set(lhs.validators.map(\.uniqueID))
        let rhsIDs = Set(rhs.validators.map(\.uniqueID))
        return lhsIDs == rhsIDs
    }
}
