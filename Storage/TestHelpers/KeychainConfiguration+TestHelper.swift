import Foundation
import NSpry

@testable import NStorage

extension KeychainConfiguration: SpryEquatable {
    static func testMake(service: String = "",
                         accessGroup: String? = "",
                         synchronizable: Bool = false,
                         decoder: JSONDecoder = .init(),
                         encoder: JSONEncoder = .init()) -> Self {
        return .init(service: service,
                     accessGroup: accessGroup,
                     synchronizable: synchronizable,
                     decoder: decoder,
                     encoder: encoder)
    }
}
