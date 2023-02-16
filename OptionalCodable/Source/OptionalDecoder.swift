import Foundation

public typealias OptionalDecodable = Decodable & Equatable

public struct OptionalDecoder<A: OptionalDecodable>: OptionalDecodable {
    public let value: A?

    public init(_ value: A?) {
        self.value = value
    }
}

public extension OptionalDecoder {
    init(from decoder: Decoder) throws {
        self.value = try? decoder.singleValueContainer().decode(A.self)
    }
}
