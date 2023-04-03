import NSpry
import UIKit

import NUIKit

final class FakeKeyboardHandler: KeyboardHandling, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case enable = "enable(for:excluded:)"
    }

    public var excluded: ExcludedViews?
    func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews?) {
        self.excluded = excluded
        return spryify(arguments: configuration, excluded)
    }
}
