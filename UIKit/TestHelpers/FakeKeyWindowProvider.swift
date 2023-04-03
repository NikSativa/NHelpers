import NSpry
import UIKit

import NUIKit

final class FakeAppWindowProvider: AppWindowProviding, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case appWindow = "appWindow()"
    }

    func appWindow() -> UIWindow {
        return spryify()
    }
}
