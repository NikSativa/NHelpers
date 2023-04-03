import Foundation
import NFoundation
import NSpry

public final class FakeUUIDProvider: UUIDProviding, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case cached
        case generateNew = "generateNew()"
    }

    public init() {}

    public var cached: String {
        return spryify()
    }

    public func generateNew() -> String {
        return spryify()
    }
}
