import Foundation
import SpryKit
import UIKit
import UIKitHelperTestHelpers
import XCTest

@testable import UIKitHelper

final class ModalPresenterTests: XCTestCase {
    func test_spec() {
        let rootViewController: FakeUIViewController = .init()
        let window: UIWindow = {
            let window = UIWindow()
            window.rootViewController = rootViewController
            return window
        }()

        let keyWindowProvider: FakeAppWindowProvider = {
            let keyWindowProvider = FakeAppWindowProvider()
            keyWindowProvider.stub(.appWindow).andReturn(window)
            keyWindowProvider.stub(.appRootViewController).andReturn(rootViewController)
            return keyWindowProvider
        }()

        let subject: ModalPresenter = .init(appRootViewControllerProvider: keyWindowProvider)

        // when the root view controller is NOT presenting anything else
        rootViewController.stub(.presentedViewController).andReturn(nil)
        XCTAssertEqual(subject.presenter(), rootViewController)
        rootViewController.resetCallsAndStubs()

        // when rootViewController's presented view controller is being dismissed
        let presentedViewController: FakeUIViewController = .init()
        presentedViewController.stub(.isBeingDismissed).andReturn(true)
        presentedViewController.stub(.isMovingFromParent).andReturn(false)
        rootViewController.stub(.presentedViewController).andReturn(presentedViewController)
        XCTAssertEqual(subject.presenter(), rootViewController)
        XCTAssertNotEqual(subject.presenter(), presentedViewController)
        presentedViewController.resetCallsAndStubs()
        rootViewController.resetCallsAndStubs()

        // when rootViewController's presented view controller is moving from parent
        presentedViewController.stub(.isBeingDismissed).andReturn(false)
        presentedViewController.stub(.isMovingFromParent).andReturn(true)
        rootViewController.stub(.presentedViewController).andReturn(presentedViewController)
        XCTAssertEqual(subject.presenter(), rootViewController)
        XCTAssertNotEqual(subject.presenter(), presentedViewController)
        presentedViewController.resetCallsAndStubs()
        rootViewController.resetCallsAndStubs()

        // when the root view controller is presenting 1 other view controller
        presentedViewController.stub(.isBeingDismissed).andReturn(false)
        presentedViewController.stub(.isMovingFromParent).andReturn(false)
        presentedViewController.stub(.presentedViewController).andReturn(nil)
        rootViewController.stub(.presentedViewController).andReturn(presentedViewController)
        XCTAssertNotEqual(subject.presenter(), rootViewController)
        XCTAssertEqual(subject.presenter(), presentedViewController)
        presentedViewController.resetCallsAndStubs()
        rootViewController.resetCallsAndStubs()

        // when the root view controller is presenting 5 other view controllers
        let lastViewController: FakeUIViewController = .init()
        lastViewController.stub(.isBeingDismissed).andReturn(false)
        lastViewController.stub(.isMovingFromParent).andReturn(false)
        lastViewController.stub(.presentedViewController).andReturn(nil)

        var viewController: FakeUIViewController?
        for _ in 0..<5 {
            let current = FakeUIViewController()
            current.stub(.isBeingDismissed).andReturn(false)
            current.stub(.isMovingFromParent).andReturn(false)
            current.stub(.presentedViewController).andReturn(viewController ?? lastViewController)
            viewController = current
        }

        rootViewController.stub(.isBeingDismissed).andReturn(false)
        rootViewController.stub(.isMovingFromParent).andReturn(false)
        rootViewController.stub(.presentedViewController).andReturn(viewController)
        let actual = subject.presenter()
        XCTAssertEqual(actual, lastViewController)
        rootViewController.resetCallsAndStubs()

        // when presenting view controller; when the root view controller is NOT presenting anything else; when animated by default
        let modalViewController: UIViewController = .init()
        rootViewController.stub(.presentedViewController).andReturn(nil)
        rootViewController.stub(.present).andReturn()
        subject.lineUp(modalViewController)
        XCTAssertHaveReceived(rootViewController, .present, with: modalViewController, true, Argument.anything)
        rootViewController.resetCallsAndStubs()
    }
}

private final class FakeUIViewController: UIViewController, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case isMovingFromParent
        case isBeingDismissed
        case presentedViewController

        case present = "present(_:animated:completion:)"
        case dismiss = "dismiss(animated:completion:)"
    }

    override var isBeingDismissed: Bool {
        return spryify()
    }

    override var isMovingFromParent: Bool {
        return spryify()
    }

    override var presentedViewController: UIViewController? {
        return spryify()
    }

    var presentedCompletion: (() -> Void)?
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentedCompletion = completion
        return spryify(arguments: viewControllerToPresent, flag, completion)
    }

    var dismissedCompletion: (() -> Void)?
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissedCompletion = completion
        return spryify(arguments: flag, completion)
    }
}
