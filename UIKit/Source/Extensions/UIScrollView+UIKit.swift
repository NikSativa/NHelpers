import UIKit

public extension UIScrollView {
    func reachedRight() -> Bool {
        // magic number: additional space
        return contentOffset.x + bounds.width >= contentSize.width - 4.0 - contentInset.right
    }

    func reachedBottom() -> Bool {
        // magic number: additional space
        return contentOffset.y + bounds.height >= contentSize.height - 4.0 - contentInset.bottom
    }

    func scrollToView(view: UIView,
                      animated: Bool = true,
                      modifier: (CGRect) -> CGRect = { $0 }) {
        let rect = convert(view.bounds, from: view)
        let modifiedRect = modifier(rect)
        scrollRectToVisible(modifiedRect, animated: animated)
    }
}
