import Foundation
import NSpry
import NValueEventier
import UIKit

@testable import NStorage

final class FakeStorage<Value>: Storage, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case publisher
        case get = "get()"
        case set = "set(_:)"
        case sink = "sink(receiveValue:)"
    }

    var eventier: ValueEventier<Value> {
        return spryify()
    }

    func get() -> Value {
        return spryify()
    }

    func set(_ newValue: Value) {
        return spryify(arguments: newValue)
    }

    func sink(receiveValue: @escaping (Value) -> Void) -> AnyCancellable {
        return spryify(arguments: receiveValue)
    }
}
