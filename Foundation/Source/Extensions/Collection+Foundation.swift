import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return index >= startIndex && index < endIndex ? self[index] : nil
    }

    func filterNils<T>() -> [T] where Element == T? {
        return compactMap { $0 }
    }

    func nilIfEmpty() -> Self? {
        return isEmpty ? nil : self
    }
}
