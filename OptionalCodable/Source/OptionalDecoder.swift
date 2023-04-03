import Foundation

public struct OptionalDecoder<A: Decodable> {
    public let value: A?

    public init(_ value: A?) {
        self.value = value
    }
}

// MARK: - Decodable

extension OptionalDecoder: Decodable {
    public init(from decoder: Decoder) throws {
        self.value = try? decoder.singleValueContainer().decode(A.self)
    }
}

// MARK: - Equatable

extension OptionalDecoder: Equatable where A: Equatable {}
