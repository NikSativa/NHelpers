import Foundation
import NSpry

@testable import NFoundation

final class FakeUUIDProvider: UUIDProviding, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case cached
        case generateNew = "generateNew()"
    }

    var cached: String {
        return spryify()
    }

    func generateNew() -> String {
        return spryify()
    }
}
