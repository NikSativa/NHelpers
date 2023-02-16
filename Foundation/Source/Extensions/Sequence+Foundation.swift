import Foundation

public extension Sequence {
    func sorted<Value>(by keyPath: KeyPath<Self.Element, Value>,
                       using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Self.Element] {
        return try sorted(by: {
            return try valuesAreInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        })
    }

    func sorted<Value: Comparable>(by keyPath: KeyPath<Self.Element, Value>) -> [Self.Element] {
        return sorted(by: keyPath, using: <)
    }

    func contains<Value>(by keyPath: KeyPath<Self.Element, Value>,
                         where predicate: (Value) throws -> Bool) rethrows -> Bool {
        return try contains { element in
            return try predicate(element[keyPath: keyPath])
        }
    }

    func contains<Value: Equatable>(by keyPath: KeyPath<Self.Element, Value>,
                                    where value: Value) -> Bool {
        return contains { element in
            return value == element[keyPath: keyPath]
        }
    }

    func group<Key: Hashable>(by key: (Iterator.Element) -> Key) -> [Key: [Iterator.Element]] {
        var groups: [Key: [Iterator.Element]] = [:]
        for element in self {
            let key = key(element)
            var cached = groups[key] ?? []
            cached.append(element)
            groups[key] = cached
        }
        return groups
    }
}
