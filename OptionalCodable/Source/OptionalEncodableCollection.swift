import Foundation

public struct OptionalEncodableCollection<T: OptionalEncodable> {
    public let values: [T]

    public init(_ values: [T]) {
        self.values = values
    }
}

// MARK: - OptionalEncodable

extension OptionalEncodableCollection: OptionalEncodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(values)
    }
}
