import SpryKit
import UIKit
import UIKitHelper

public final class FakeKeyboardHandler: KeyboardHandling, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case enable = "enable(for:excluded:)"
    }

    public var excluded: ExcludedViews?
    public func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews?) {
        self.excluded = excluded
        return spryify(arguments: configuration, excluded)
    }
}
