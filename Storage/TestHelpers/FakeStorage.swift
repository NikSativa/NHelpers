import Foundation
import NSpry
import NStorage
import NValueEventier
import UIKit

public final class FakeStorage<Value>: Storage, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case publisher
        case get = "get()"
        case set = "set(_:)"
        case sink = "sink(receiveValue:)"
    }

    public var eventier: ValueEventier<Value> {
        return spryify()
    }

    public var value: Value {
        get {
            return get()
        }
        set {
            set(newValue)
        }
    }

    private func get() -> Value {
        return spryify()
    }

    private func set(_ newValue: Value) {
        return spryify(arguments: newValue)
    }

    public func sink(receiveValue: @escaping (Value) -> Void) -> AnyCancellable {
        return spryify(arguments: receiveValue)
    }
}
