import NOptionalCodable
import NSpry

extension OptionalDecodableDictionary: SpryEquatable {
    public static func testMake(values: [K: V] = [:]) -> Self {
        return .init(values)
    }
}
