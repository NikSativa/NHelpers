import Foundation
import NOptionalCodable
import NSpry

extension OptionalCodableCollection: SpryEquatable {
    public static func testMake(values: [T] = []) -> Self {
        return .init(values)
    }
}
