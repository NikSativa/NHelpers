import Foundation
import UIKit

public enum ModalPresenterSource {
    case view(UIView)
    case barButtonItem(UIBarButtonItem)
}

public protocol ModalPresenting {
    typealias Source = ModalPresenterSource
    typealias Callback = () -> Void

    var topPresenter: UIViewController { get }

    func show(_ viewController: UIViewController,
              source: Source?,
              animated: Bool,
              completion: @escaping Callback)

    func lineUp(_ viewController: UIViewController,
                source: Source?,
                animated: Bool,
                completion: @escaping Callback)

    func dismiss(animated: Bool)
}

public extension ModalPresenting {
    func show(_ viewController: UIViewController,
              source: Source? = nil,
              animated: Bool = true,
              completion: @escaping Callback = {}) {
        show(viewController,
             source: source,
             animated: animated,
             completion: completion)
    }

    func lineUp(_ viewController: UIViewController,
                source: Source? = nil,
                animated: Bool = true,
                completion: @escaping Callback = {}) {
        lineUp(viewController,
               source: source,
               animated: animated,
               completion: completion)
    }

    func dismiss(animated: Bool = true) {
        dismiss(animated: animated)
    }
}

public final class ModalPresenter {
    public struct State {
        let viewController: UIViewController
        let animated: Bool
        let completion: ModalPresenting.Callback?
        let source: Source?
    }

    private let popoverPresentationControllerDelegate: PopoverPresentationControllerDelegate = .init()
    private weak var currentViewController: UIViewController?
    private(set) var queue: [State] = []
    private var isChecking = false
    private let keyWindowProviding: AppWindowProviding

    private var keyWindow: UIWindow {
        return keyWindowProviding.appWindow()
    }

    public init(keyWindowProvider: AppWindowProviding) {
        self.keyWindowProviding = keyWindowProvider
    }

    private func showNextViewController() {
        if let _ = currentViewController {
            return
        }

        guard !queue.isEmpty else {
            return
        }

        let state = queue.removeFirst()
        currentViewController = state.viewController

        show(state)

        startCheckingViewControllerAvailability()
    }

    private func show(_ state: State) {
        let task = {
            let presenter = self.presenter()
            self.prepare(state.viewController, on: state.source)
            presenter.present(state.viewController, animated: state.animated, completion: nil)
        }

        if Thread.isMainThread {
            task()
        } else {
            DispatchQueue.main.sync(execute: task)
        }
    }

    private func prepare(_ viewController: UIViewController, on source: ModalPresenterSource?) {
        guard let source = source else {
            return
        }

        switch source {
        case .view(let view):
            viewController.modalPresentationStyle = .popover
            if let popoverController = viewController.popoverPresentationController {
                configure(popover: popoverController)
                popoverController.sourceView = view
                popoverController.sourceRect = view.bounds
                popoverController.permittedArrowDirections = .any
            }
        case .barButtonItem(let item):
            viewController.modalPresentationStyle = .popover
            if let popoverController = viewController.popoverPresentationController {
                configure(popover: popoverController)
                popoverController.barButtonItem = item
                popoverController.permittedArrowDirections = .any
            }
        }
    }

    private func configure(popover: UIPopoverPresentationController) {
        popover.delegate = popoverPresentationControllerDelegate
        popover.canOverlapSourceViewRect = true
    }

    private func startCheckingViewControllerAvailability() {
        if isChecking {
            return
        }

        isChecking = true
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + .milliseconds(1)) { [weak self] in
            self?.isChecking = false
            self?.checkViewControllerAvailability()
        }
    }

    private func checkViewControllerAvailability() {
        if let _ = currentViewController {
            startCheckingViewControllerAvailability()
        } else {
            showNextViewController()
        }
    }

    internal func presenter() -> UIViewController {
        guard let rootViewController = keyWindow.rootViewController else {
            assertionFailure("Cannot present a full screen modal when you don't have a rootViewController")
            return UIViewController()
        }

        // the root view controller is presenting another view controller, walk up to the tippy-top

        let isStillInViewHierachy = { (viewController: UIViewController?) -> Bool in
            let isBeingDismissed = viewController?.isBeingDismissed ?? true
            let isMovingFromParent = viewController?.isMovingFromParent ?? true

            return !(isBeingDismissed || isMovingFromParent)
        }

        var foundPresentedViewController = rootViewController
        while foundPresentedViewController.presentedViewController != nil,
              isStillInViewHierachy(foundPresentedViewController.presentedViewController) {
            if let tempViewController = foundPresentedViewController.presentedViewController {
                foundPresentedViewController = tempViewController
            }
        }

        return foundPresentedViewController
    }
}

// MARK: - ModalPresenting

extension ModalPresenter: ModalPresenting {
    public var topPresenter: UIViewController {
        return presenter()
    }

    public func show(_ viewController: UIViewController, source: Source?, animated: Bool, completion: @escaping Callback) {
        let state = State(viewController: viewController, animated: animated, completion: completion, source: source)
        show(state)
    }

    public func lineUp(_ viewController: UIViewController, source: Source?, animated: Bool, completion: @escaping Callback) {
        let state = State(viewController: viewController, animated: animated, completion: completion, source: source)
        queue.append(state)
        checkViewControllerAvailability()
    }

    public func dismiss(animated: Bool) {
        currentViewController?.dismiss(animated: animated) { [weak self] in
            self?.checkViewControllerAvailability()
        }
    }
}

// MARK: - ModalPresenter.PopoverPresentationControllerDelegate

private extension ModalPresenter {
    final class PopoverPresentationControllerDelegate: NSObject, UIPopoverPresentationControllerDelegate {
        func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
            return .none
        }
    }
}
