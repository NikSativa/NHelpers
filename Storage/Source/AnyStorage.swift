import Foundation
import NObservable

public final class AnyStorage<Value>: Storage {
    private let _get: () -> Value
    private let _set: (Value) -> Void
    private let _publisher: () -> Observable<Value>

    public init<U: Storage>(_ base: U) where U.Value == Value {
        self._get = base.get
        self._set = base.set
        self._publisher = { base.eventier }
    }

    public var eventier: Observable<Value> {
        return _publisher()
    }

    public func get() -> Value {
        return _get()
    }

    public func set(_ newValue: Value) {
        _set(newValue)
    }
}
