import NSpry

@testable import NOptionalCodable

extension OptionalEncodableCollection: SpryEquatable {
    static func testMake(values: [T] = []) -> Self {
        return .init(values)
    }
}
