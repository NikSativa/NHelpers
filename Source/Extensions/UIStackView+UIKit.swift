import Foundation
import UIKit

public extension UIStackView {
    convenience init(axis: NSLayoutConstraint.Axis,
                     alignment: Alignment = .fill,
                     distribution: Distribution = .fillProportionally,
                     spacing: CGFloat = 0) {
        self.init()
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }

    func swap(_ view1: UIView, with view2: UIView) {
        guard let view2TargetIndex = arrangedSubviews.firstIndex(of: view1),
              let view1TargetIndex = arrangedSubviews.firstIndex(of: view2) else {
            return
        }

        removeArrangedSubview(view1)
        removeArrangedSubview(view2)

        if view2TargetIndex > view1TargetIndex {
            insertArrangedSubview(view1, at: view1TargetIndex)
            insertArrangedSubview(view2, at: view2TargetIndex)
        } else {
            insertArrangedSubview(view2, at: view2TargetIndex)
            insertArrangedSubview(view1, at: view1TargetIndex)
        }
    }

    @available(iOS 11.0, *)
    func set(directionalInsets insets: UIEdgeInsets) {
        isLayoutMarginsRelativeArrangement = true
        directionalLayoutMargins = .init(top: insets.top,
                                         leading: insets.left,
                                         bottom: insets.bottom,
                                         trailing: insets.right)
    }

    func set(insets: UIEdgeInsets) {
        isLayoutMarginsRelativeArrangement = true
        layoutMargins = insets
    }
}

public extension UIStackView {
    @available(*, unavailable, message: "use 'removeAllArrangedViews'")
    @objc
    override func removeAllSubviews() {
        super.removeAllSubviews()
    }

    func removeAllArrangedViews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
