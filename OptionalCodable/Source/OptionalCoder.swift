import Foundation

public struct OptionalCoder<A: Codable> {
    public let value: A?

    public init(_ value: A?) {
        self.value = value
    }
}

// MARK: - Codable

extension OptionalCoder: Codable {
    public init(from decoder: Decoder) throws {
        self.value = try? decoder.singleValueContainer().decode(A.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try? container.encode(value)
    }
}
