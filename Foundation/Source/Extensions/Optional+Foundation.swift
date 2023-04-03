import Foundation

public extension Optional {
    var isNil: Bool {
        return self == nil
    }

    func unwrap(_ error: some Error) throws -> Wrapped {
        switch self {
        case .none:
            throw error
        case .some(let t):
            return t
        }
    }

    func unwrapOrEmpty<Element>() -> [Element] where Wrapped == [Element] {
        return self ?? []
    }

    func unwrapOrEmpty<Key, Value>() -> [Key: Value] where Wrapped == [Key: Value] {
        return self ?? [:]
    }

    func or(_ other: Wrapped) -> Wrapped {
        return self ?? other
    }
}

public extension Optional where Wrapped: Collection {
    func nilIfEmpty() -> Wrapped? {
        switch self {
        case .none:
            return .none
        case .some(let value):
            return value.nilIfEmpty()
        }
    }
}
