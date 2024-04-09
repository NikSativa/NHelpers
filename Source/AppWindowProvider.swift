import Foundation
import UIKit

public protocol AppWindowProviding: AppRootViewControllerProviding {
    func appWindow() -> UIWindow
}

public final class AppWindowProvider {
    private let window: UIWindow

    public init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - AppWindowProviding

extension AppWindowProvider: AppWindowProviding {
    public func appWindow() -> UIWindow {
        return window
    }

    public func appRootViewController() -> UIViewController {
        guard let rootViewController = window.rootViewController else {
            assertionFailure("Cannot present a full screen modal when you don't have a rootViewController")
            return UIViewController()
        }
        return rootViewController
    }
}
