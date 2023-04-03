import Foundation

public protocol UUIDProviding {
    var cached: String { get }
    func generateNew(andUpdateCache save: Bool) -> String
}

public extension UUIDProviding {
    func generateNew(andUpdateCache save: Bool = false) -> String {
        generateNew(andUpdateCache: save)
    }
}

public final class UUIDProvider {
    private var _cached: String?

    public init() {}
}

// MARK: - UUIDProviding

extension UUIDProvider: UUIDProviding {
    public var cached: String {
        return _cached ?? generateNew(andUpdateCache: true)
    }

    public func generateNew(andUpdateCache save: Bool) -> String {
        let value = UUID().uuidString
        if save || _cached.isNil {
            _cached = value
        }
        return value
    }
}
