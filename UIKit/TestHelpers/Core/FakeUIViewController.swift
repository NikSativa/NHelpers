import NSpry
import UIKit

@testable import NUIKit

public final class FakeUIViewController: UIViewController, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case isMovingFromParent
        case isBeingDismissed
        case presentedViewController

        case present = "present(_:animated:completion:)"
        case dismiss = "dismiss(animated:completion:)"
    }

    override public var isBeingDismissed: Bool {
        return spryify()
    }

    override public var isMovingFromParent: Bool {
        return spryify()
    }

    override public var presentedViewController: UIViewController? {
        return spryify()
    }

    public var presentedCompletion: (() -> Void)?
    override public func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedCompletion = completion
        return spryify(arguments: viewControllerToPresent, flag, completion)
    }

    public var dismissedCompletion: (() -> Void)?
    override public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissedCompletion = completion
        return spryify(arguments: flag, completion)
    }
}
