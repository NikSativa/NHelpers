import Foundation
import NOptionalCodable
import NSpry

extension OptionalCoder: SpryEquatable {
    public static func testMake(value: A? = nil) -> Self {
        return .init(value)
    }
}
