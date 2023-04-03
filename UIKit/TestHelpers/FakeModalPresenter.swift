import NSpry
import UIKit

import NUIKit

final class FakeModalPresenter: ModalPresenting, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case present = "present(_:source:animated:completion:)"
        case dismissAnimated = "dismiss(animated:)"
        case topPresenter
    }

    var topPresenter: UIViewController {
        return spryify()
    }

    private(set) var completionCallback: Callback?
    func present(_ viewController: UIViewController, source _: Source?, animated: Bool, completion: @escaping Callback) {
        completionCallback = completion
        return spryify(arguments: viewController, animated)
    }

    func dismiss(animated: Bool) {
        return spryify(arguments: animated)
    }
}
