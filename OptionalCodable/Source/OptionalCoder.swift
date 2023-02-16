import Foundation

public typealias OptionalCodable = Codable & Equatable

public struct OptionalCoder<A: OptionalCodable> {
    public let value: A?

    public init(_ value: A?) {
        self.value = value
    }
}

// MARK: - OptionalCodable

extension OptionalCoder: OptionalCodable {
    public init(from decoder: Decoder) throws {
        self.value = try? decoder.singleValueContainer().decode(A.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try? container.encode(value)
    }
}
