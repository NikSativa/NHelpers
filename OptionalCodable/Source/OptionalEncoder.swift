import Foundation

public typealias OptionalEncodable = Encodable & Equatable

public struct OptionalEncoder<A: OptionalEncodable> {
    public let value: A?

    public init(_ value: A?) {
        self.value = value
    }
}

// MARK: - OptionalEncodable

extension OptionalEncoder: OptionalEncodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try? container.encode(value)
    }
}
