import Foundation

public struct OptionalCodableCollection<T: Codable> {
    public let values: [T]

    public init(_ values: [T]) {
        self.values = values
    }
}

// MARK: - Codable

extension OptionalCodableCollection: Codable {
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer().decode([OptionalDecoder<T>].self)
        self.values = (container ?? []).compactMap(\.value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(values)
    }
}

extension OptionalCodableCollection: Equatable where T: Equatable {}
