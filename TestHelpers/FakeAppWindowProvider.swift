import SpryKit
import UIKit
import UIKitHelper

public final class FakeAppWindowProvider: AppWindowProviding, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case appWindow = "appWindow()"
        case appRootViewController = "appRootViewController()"
    }

    public init() {}

    public func appWindow() -> UIWindow {
        return spryify()
    }

    public func appRootViewController() -> UIViewController {
        return spryify()
    }
}
