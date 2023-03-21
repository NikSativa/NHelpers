import Foundation

public extension Array {
    func mapToDictionary<Key: Hashable, NewElement>(_ mapper: (Element) -> (key: Key, newElement: NewElement)) -> [Key: NewElement] {
        var result: [Key: NewElement] = [:]
        for element in self {
            let value = mapper(element)
            result[value.key] = value.newElement
        }
        return result
    }

    func compactMapToDictionary<Key: Hashable, NewElement>(_ mapper: (Element) -> (key: Key, newElement: NewElement)?) -> [Key: NewElement] {
        var result: [Key: NewElement] = [:]
        for element in self {
            if let value = mapper(element) {
                result[value.key] = value.newElement
            }
        }
        return result
    }

    @discardableResult
    mutating func sort<Value>(by keyPath: KeyPath<Self.Element, Value>,
                              using valuesAreInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> Self {
        self = try sorted(by: keyPath, using: valuesAreInIncreasingOrder)
        return self
    }

    @discardableResult
    mutating func sort(by keyPath: KeyPath<Self.Element, some Comparable>) -> Self {
        self = sorted(by: keyPath)
        return self
    }

    mutating func removeAll<Value: Equatable>(by keyPath: KeyPath<Self.Element, Value>,
                                              where shouldBeRemoved: (Value) throws -> Bool) rethrows {
        try removeAll { element in
            return try shouldBeRemoved(element[keyPath: keyPath])
        }
    }

    mutating func removeAll<Value: Equatable>(by keyPath: KeyPath<Self.Element, Value>,
                                              where shouldBeRemoved: Value) {
        removeAll { element in
            return element[keyPath: keyPath] == shouldBeRemoved
        }
    }

    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

public extension Array where Element: Equatable {
    func at(indices: [Int]) -> [Element] {
        return indices.map {
            return self[$0]
        }
    }

    func chunked(into size: Int) -> [[Element]] {
        if size <= 0 {
            return []
        }

        return stride(from: 0, to: count, by: size).map {
            return Array(self[$0..<Swift.min($0 + size, count)])
        }
    }
}

public extension Array where Element: Hashable {
    func unified(keepOrder: Bool = false) -> [Element] {
        if keepOrder {
            var s: Set<Element> = []
            var result: [Element] = []
            for element in self {
                if s.insert(element).inserted {
                    result.append(element)
                }
            }
            return result
        } else {
            let s = Set(self)
            return Array(s)
        }
    }

    mutating func unify(keepOrder: Bool) {
        return self = unified(keepOrder: keepOrder)
    }
}

public extension Array {
    func unified<T: Hashable>(by key: KeyPath<Element, T>) -> (unique: [Element], skipped: [Element]) {
        var s: Set<T> = []
        var result: [Element] = []
        var skipped: [Element] = []
        for element in self {
            if s.insert(element[keyPath: key]).inserted {
                result.append(element)
            } else {
                skipped.append(element)
            }
        }
        return (result, skipped)
    }
}

public func + <T>(list: [T], obj: T) -> [T] {
    return list + [obj]
}

public func + <T>(obj: T, list: [T]) -> [T] {
    return [obj] + list
}

public func += <T>(list: inout [T], obj: T) {
    list.append(obj)
}

public func += <T>(list: inout [T], obj: T?) {
    if let obj {
        list.append(obj)
    }
}

public func -= <T: Equatable>(list: inout [T], obj: T) {
    while let index = list.firstIndex(of: obj) {
        list.remove(at: index)
    }
}

public func -= <T: Equatable>(list: inout [T], obj: T?) {
    if let obj {
        while let index = list.firstIndex(of: obj) {
            list.remove(at: index)
        }
    }
}
