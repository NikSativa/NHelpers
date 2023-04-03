import Foundation
import NOptionalCodable
import NSpry

extension OptionalCodableDictionary: SpryEquatable {
    public static func testMake(values: [K: V] = [:]) -> Self {
        return .init(values)
    }
}
