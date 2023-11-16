import Foundation
import NValueEventier

public final class AnyStorage<Value>: Storage {
    private let _get: () -> Value
    private let _set: (Value) -> Void
    private let _publisher: () -> ValueEventier<Value>

    public init<U: Storage>(_ base: U) where U.Value == Value {
        self._get = base.get
        self._set = base.set
        self._publisher = { base.eventier }
    }

    public var eventier: ValueEventier<Value> {
        return _publisher()
    }

    public func get() -> Value {
        return _get()
    }

    public func set(_ newValue: Value) {
        _set(newValue)
    }
}
