import UIKit

public extension UIViewController {
    func add(childController: UIViewController, andFill placeholder: UIView? = nil, relatedToSafeArea: Bool = false) {
        (placeholder ?? view).addAndFill(childController.view, relatedToSafeArea: relatedToSafeArea)
        addChild(childController)
    }

    func removeFromParentAndSuperview() {
        view.removeFromSuperview()
        removeFromParent()
    }

    func clearBackground() {
        view.clearBackground()
    }
}
