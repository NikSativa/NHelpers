import NSpry

@testable import NOptionalCodable

extension OptionalDecoder: SpryEquatable {
    static func testMake(value: A? = nil) -> Self {
        return .init(value)
    }
}
