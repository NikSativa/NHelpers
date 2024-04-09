import Foundation
import UIKit

public protocol KeyboardHandling {
    typealias ExcludedViews = () -> [UIView]
    func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews?)
}

public extension KeyboardHandling {
    func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews? = nil) {
        enable(for: configuration, excluded: excluded)
    }

    func enable(for view: UIScrollView, touchView: UIView, excluded: ExcludedViews? = nil) {
        enable(for: .init(view: view, touchView: touchView), excluded: excluded)
    }
}
