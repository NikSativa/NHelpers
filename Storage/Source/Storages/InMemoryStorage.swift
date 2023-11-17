import Foundation
import NValueEventier

public final class InMemoryStorage<Value>: Storage {
    public private(set) lazy var eventier: ValueEventier<Value> = .init(wrappedValue: value)
    public var value: Value {
        willSet {
            objectWillChange.send()
        }
        didSet {
            eventier.wrappedValue = value
        }
    }

    public init(value: Value) {
        self.value = value
    }
}

public extension InMemoryStorage where Value: ExpressibleByNilLiteral {
    convenience init() {
        self.init(value: nil)
    }
}

// MARK: - ExpressibleByNilLiteral

extension InMemoryStorage: ExpressibleByNilLiteral where Value: ExpressibleByNilLiteral {
    public convenience init(nilLiteral: ()) {
        self.init(value: nil)
    }
}
