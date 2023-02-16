import NSpry

@testable import NOptionalCodable

extension OptionalEncoder: SpryEquatable {
    static func testMake(value: A? = nil) -> Self {
        return .init(value)
    }
}
