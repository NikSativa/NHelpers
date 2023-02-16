import Foundation

public struct OptionalEncodableDictionary<K: Encodable & Hashable, V: OptionalEncodable> {
    public let values: [K: V]

    public init(_ values: [K: V]) {
        self.values = values
    }
}

// MARK: - OptionalEncodable

extension OptionalEncodableDictionary: OptionalEncodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(values)
    }
}
