import Foundation

public struct OptionalCodableCollection<T: OptionalCodable> {
    public let values: [T]

    public init(_ values: [T]) {
        self.values = values
    }
}

// MARK: - OptionalCodable

extension OptionalCodableCollection: OptionalCodable {
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer().decode([OptionalDecoder<T>].self)
        self.values = (container ?? []).compactMap(\.value)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(values)
    }
}
