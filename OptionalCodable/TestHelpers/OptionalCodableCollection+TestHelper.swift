import Foundation
import NSpry

@testable import NOptionalCodable

extension OptionalCodableCollection: SpryEquatable {
    static func testMake(values: [T] = []) -> Self {
        return .init(values)
    }
}
