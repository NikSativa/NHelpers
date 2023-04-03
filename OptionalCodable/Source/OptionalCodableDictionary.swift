import Foundation

public struct OptionalCodableDictionary<K: Codable & Hashable, V: Codable> {
    public let values: [K: V]

    public init(_ values: [K: V]) {
        self.values = values
    }
}

// MARK: - Codable

extension OptionalCodableDictionary: Codable {
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer().decode([K: OptionalDecoder<V>].self)
        self.values = (container ?? [:]).compactMapValues(\.value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(values)
    }
}

extension OptionalCodableDictionary: Equatable where V: Equatable {}
