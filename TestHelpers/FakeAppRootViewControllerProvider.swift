import Foundation
import SpryKit
import UIKit
import UIKitHelper

public final class FakeAppRootViewControllerProvider: AppRootViewControllerProviding, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case appRootViewController = "appRootViewController()"
    }

    public func appRootViewController() -> UIViewController {
        return spryify()
    }
}
