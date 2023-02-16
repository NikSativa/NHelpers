import Foundation
import UIKit

public protocol AppWindowProviding: AnyObject {
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
}
