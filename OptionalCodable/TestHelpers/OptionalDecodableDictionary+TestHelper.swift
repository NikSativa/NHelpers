import NSpry

@testable import NOptionalCodable

extension OptionalDecodableDictionary: SpryEquatable {
    static func testMake(values: [K: V] = [:]) -> Self {
        return .init(values)
    }
}
