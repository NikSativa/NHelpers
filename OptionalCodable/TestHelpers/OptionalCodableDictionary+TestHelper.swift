import Foundation
import NSpry

@testable import NOptionalCodable

extension OptionalCodableDictionary: SpryEquatable {
    static func testMake(values: [K: V] = [:]) -> Self {
        return .init(values)
    }
}
