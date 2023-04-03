import Foundation

public struct OptionalDecodableCollection<T: Decodable> {
    public let values: [T]

    public init(_ values: [T]) {
        self.values = values
    }
}

// MARK: - Decodable

extension OptionalDecodableCollection: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try? decoder.singleValueContainer().decode([OptionalDecoder<T>].self)
        self.values = (container ?? []).compactMap(\.value)
    }
}

extension OptionalDecodableCollection: Equatable where T: Equatable {}
