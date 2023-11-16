import Foundation
import NValueEventier

public protocol Storage: AnyObject {
    associatedtype Value

    var eventier: ValueEventier<Value> { get }

    func get() -> Value
    func set(_ newValue: Value)

    func sink(receiveValue: @escaping (Value) -> Void) -> AnyCancellable
}

public extension Storage {
    var value: Value {
        get {
            get()
        }
        set {
            set(newValue)
        }
    }

    func sink(receiveValue: @escaping (Value) -> Void) -> AnyCancellable {
        return eventier.sink(receiveValue: receiveValue)
    }

    func toAny() -> AnyStorage<Value> {
        if let self = self as? AnyStorage<Value> {
            return self
        }

        return AnyStorage(self)
    }
}
