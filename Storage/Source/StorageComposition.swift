import Foundation
import NObservable

public func + <S1: Storage, S2: Storage>(lhs: S1, rhs: S2) -> AnyStorage<S1.Value>
where S1.Value == S2.Value, S1.Value: ExpressibleByNilLiteral & Equatable {
    return StorageComposition(storages: [lhs.toAny(), rhs.toAny()]).toAny()
}

public func zip<Value: ExpressibleByNilLiteral & Equatable>(_ storages: AnyStorage<Value>...) -> AnyStorage<Value> {
    return StorageComposition(storages: storages).toAny()
}

final class StorageComposition<Value: ExpressibleByNilLiteral & Equatable>: Storage {
    private(set) var eventier: Observable<Value>
    fileprivate let storages: [AnyStorage<Value>]
    private var observers: [AnyCancellable] = []
    private var isSyncing: Bool = false

    init(storages: [AnyStorage<Value>]) {
        assert(!storages.isEmpty, "we hit a snag! maybe in runtime some Storages was filtered")
        if storages.isEmpty {
            // maybe in runtime Storages was filtered due some lack options
            // to make shure that the storage will work at any case, we are adding default InMemory storage
            self.storages = [InMemoryStorage<Value>().toAny()]
        } else {
            self.storages = storages
        }

        var found: Value = nil
        for storage in storages {
            let value = storage.value
            if value != found {
                found = value
                break
            }
        }

        self.eventier = .init(wrappedValue: found)
        self.observers = storages.map { actaul in
            return actaul.eventier.dropFirst().sink { [unowned self, unowned actaul] newValue in
                if isSyncing {
                    return
                }

                self.isSyncing = true
                for storage in self.storages {
                    if actaul !== storage {
                        storage.set(newValue)
                    }
                }
                self.isSyncing = false
            }
        }
    }

    func get() -> Value {
        let empty: Value = nil
        let found: (offset: Int, element: Value)? = storages.lazy
            .map(\.value)
            .enumerated()
            .first(where: { $0.1 != empty })

        if let found {
            // recursively set the same value to the previous storages
            // in common case this is improvement of speed via saving stored value in the inMemory storage
            for i in (0..<found.offset).reversed() {
                storages[i].value = found.element
            }
        }

        return found?.element ?? empty
    }

    func set(_ newValue: Value) {
        for storage in storages {
            storage.set(newValue)
        }
        eventier.wrappedValue = newValue
    }
}
