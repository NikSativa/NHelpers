import NOptionalCodable
import NSpry

extension OptionalDecoder: SpryEquatable {
    public static func testMake(value: A? = nil) -> Self {
        return .init(value)
    }
}
