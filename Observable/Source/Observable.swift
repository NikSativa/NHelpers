import Combine
import Foundation

@propertyWrapper
public final class Observable<Output>: Combine.Publisher {
    public typealias Failure = Never

    private var observers: Set<AnyCancellable> = []
    private let syncOnMainThread: Bool
    private let subject: any Subject<Output, Failure>
    private var isIgnoringNewValues: Bool = true

    public var wrappedValue: Output {
        didSet {
            guard isIgnoringNewValues else {
                return
            }

            if syncOnMainThread, !Thread.isMainThread {
                DispatchQueue.main.sync {
                    subject.send(wrappedValue)
                }
            } else {
                subject.send(wrappedValue)
            }
        }
    }

    public required init(wrappedValue: Output, syncOnMainThread: Bool = false) {
        self.subject = CurrentValueSubject(wrappedValue)
        self.wrappedValue = wrappedValue
        self.syncOnMainThread = syncOnMainThread
    }

    public lazy var projectedValue: AnyPublisher<Output, Failure> = {
        return subject.eraseToAnyPublisher()
    }()

    public func receive<S>(subscriber: S)
    where S: Subscriber, Failure == S.Failure, Output == S.Input {
        subject.receive(subscriber: subscriber)
    }

    public func observe<New>(keyPath: WritableKeyPath<Output, New>) -> Observable<New> {
        let newValue = wrappedValue[keyPath: keyPath]
        let new = Observable<New>(wrappedValue: newValue, syncOnMainThread: syncOnMainThread)

        map(keyPath)
            .dropFirst()
            .sink { [unowned new, weak self] value in
                self?.isIgnoringNewValues = false
                new.wrappedValue = value
                self?.isIgnoringNewValues = true
            }.store(in: &new.observers)

        new.dropFirst()
            .sink { [unowned self, weak new] value in
                new?.isIgnoringNewValues = false
                wrappedValue[keyPath: keyPath] = value
                new?.isIgnoringNewValues = true
            }.store(in: &observers)

        return new
    }
}

public extension Observable where Output: ExpressibleByNilLiteral {
    convenience init() {
        self.init(wrappedValue: nil)
    }
}

public extension Observable where Output: ExpressibleByArrayLiteral {
    convenience init() {
        self.init(wrappedValue: [])
    }
}

public extension Observable where Output: ExpressibleByDictionaryLiteral {
    convenience init() {
        self.init(wrappedValue: [:])
    }
}

public extension Publisher {
    func filterNils<NewOutput>() -> Publishers.CompactMap<Self, NewOutput>
    where Output == NewOutput? {
        return compactMap {
            return $0
        }
    }

    func mapVoid() -> Publishers.Map<Self, Void> {
        return map(makeVoid(_:))
    }
}

private func makeVoid<T>(_: T) -> Void {}
