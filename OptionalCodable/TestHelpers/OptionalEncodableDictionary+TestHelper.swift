import NSpry

@testable import NOptionalCodable

extension OptionalEncodableDictionary: SpryEquatable {
    static func testMake(values: [K: V] = [:]) -> Self {
        return .init(values)
    }
}
