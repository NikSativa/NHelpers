import Foundation
import NObservable

final class InMemoryStorage<Output>: Storage {
    private(set) var eventier: Observable<Output>
    private(set) var value: Output

    init(value: Output) {
        self.value = value
        self.eventier = .init(wrappedValue: value)
    }

    func get() -> Output {
        return value
    }

    func set(_ newValue: Output) {
        value = newValue
        eventier.wrappedValue = newValue
    }
}

extension InMemoryStorage where Output: ExpressibleByNilLiteral {
    convenience init() {
        self.init(value: nil)
    }
}
