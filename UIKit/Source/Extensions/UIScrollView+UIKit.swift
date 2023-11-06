import UIKit

public extension UIScrollView {
    func reachedRight(additionalSpace magicNumber: CGFloat = 4) -> Bool {
        guard contentSize.width >= bounds.width else {
            return false
        }

        return contentOffset.x + bounds.width >= contentSize.width - magicNumber - contentInset.right
    }

    func reachedBottom(additionalSpace magicNumber: CGFloat = 4) -> Bool {
        guard contentSize.height >= bounds.height else {
            return false
        }

        return contentOffset.y + bounds.height >= contentSize.height - magicNumber - contentInset.bottom
    }

    func scrollToView(view: UIView,
                      animated: Bool = true,
                      modifier: (CGRect) -> CGRect = { $0 }) {
        let rect = convert(view.bounds, from: view)
        let modifiedRect = modifier(rect)
        scrollRectToVisible(modifiedRect, animated: animated)
    }
}
