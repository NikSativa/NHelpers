import NSpry

@testable import NOptionalCodable

extension OptionalDecodableCollection: SpryEquatable {
    static func testMake(values: [T] = []) -> Self {
        return .init(values)
    }
}
