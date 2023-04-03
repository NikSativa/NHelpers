import NOptionalCodable
import NSpry

extension OptionalDecodableCollection: SpryEquatable {
    public static func testMake(values: [T] = []) -> Self {
        return .init(values)
    }
}
