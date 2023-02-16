import Foundation

public struct Lifetime: Codable, Equatable {
    public static let infinite = Lifetime()
    public static let oneHour = Lifetime(expires: 3600)
    public static let fourHours = Lifetime(expires: 3600 * 4)
    public static let twentyFourHours = Lifetime(expires: 3600 * 24)

    private let interval: TimeInterval
    public var isInfinite: Bool {
        return interval < 0
    }

    public init() {
        self.interval = -1
    }

    public init(expires interval: TimeInterval) {
        self.interval = interval
    }

    public func hasExpired(from date: Date, currentDate: Date) -> Bool {
        if isInfinite {
            return false
        }

        return currentDate.timeIntervalSince(date) > interval
    }
}

// MARK: - ExpressibleByFloatLiteral

extension Lifetime: ExpressibleByFloatLiteral {
    public init(floatLiteral value: Float) {
        self.init(expires: TimeInterval(value))
    }
}

// MARK: - ExpressibleByIntegerLiteral

extension Lifetime: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.init(expires: TimeInterval(value))
    }
}

@propertyWrapper
public struct Expirable<Value: ExpressibleByNilLiteral> {
    private var _value: Value = nil
    private let lifetime: Lifetime
    private var savedDate = Date()

    private var hasExpired: Bool {
        return lifetime.hasExpired(from: savedDate, currentDate: Date())
    }

    public var wrappedValue: Value {
        get {
            return hasExpired ? nil : _value
        }
        set {
            savedDate = Date()
            _value = newValue
        }
    }

    public init(lifetimeInterval interval: TimeInterval,
                value: Value = nil) {
        self.lifetime = Lifetime(expires: interval)
        self._value = value
    }

    public init(lifetime: Lifetime,
                value: Value = nil) {
        self.lifetime = lifetime
        self._value = value
    }
}
