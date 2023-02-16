import UIKit

public extension UIGestureRecognizer {
    var isTouchUpInside: Bool {
        guard state == .ended else {
            return false
        }

        guard let view = view else {
            return false
        }

        let location = location(in: view)
        let bounds = view.bounds
        return bounds.contains(location)
    }
}
