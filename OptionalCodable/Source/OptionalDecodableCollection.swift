import Foundation

public struct OptionalDecodableCollection<T: OptionalDecodable> {
    public let values: [T]

    public init(_ values: [T]) {
        self.values = values
    }
}

// MARK: - OptionalDecodable

extension OptionalDecodableCollection: OptionalDecodable {
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer().decode([OptionalDecoder<T>].self)
        self.values = (container ?? []).compactMap(\.value)
    }
}
