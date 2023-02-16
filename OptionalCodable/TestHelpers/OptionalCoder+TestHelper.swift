import Foundation
import NSpry

@testable import NOptionalCodable

extension OptionalCoder: SpryEquatable {
    static func testMake(value: A? = nil) -> Self {
        return .init(value)
    }
}
