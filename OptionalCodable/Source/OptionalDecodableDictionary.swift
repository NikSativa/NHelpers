import Foundation

public struct OptionalDecodableDictionary<K: Decodable & Hashable, V: Decodable> {
    public let values: [K: V]

    public init(_ values: [K: V]) {
        self.values = values
    }
}

// MARK: - Decodable

extension OptionalDecodableDictionary: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer().decode([K: OptionalDecoder<V>].self)
        self.values = (container ?? [:]).compactMapValues(\.value)
    }
}

extension OptionalDecodableDictionary: Equatable where V: Equatable {}
