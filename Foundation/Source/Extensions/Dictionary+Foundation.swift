import Foundation

public extension Dictionary {
    subscript<R: RawRepresentable>(_ key: R) -> Value? where R.RawValue == Key {
        return self[key.rawValue]
    }

    func filterNils<T>() -> [Key: T] where Value == T? {
        return compactMapValues { $0 }
    }
}
