import UIKit

public extension UIView {
    @objc
    func addAndFill(_ subview: UIView,
                    relatedToSafeArea: Bool = false,
                    constant: CGFloat) {
        addAndFill(subview,
                   relatedToSafeArea: relatedToSafeArea,
                   insets: .init(top: constant,
                                 left: constant,
                                 bottom: constant,
                                 right: constant))
    }

    @objc
    func addAndFill(_ subview: UIView,
                    relatedToSafeArea: Bool = false,
                    insets: UIEdgeInsets = .zero) {
        addSubview(subview)

        subview.enableConstraints()

        if relatedToSafeArea {
            subview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: insets.top).isActive = true
            subview.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: insets.left).isActive = true
            subview.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -insets.bottom).isActive = true
            subview.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -insets.right).isActive = true
        } else {
            subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
            subview.leftAnchor.constraint(equalTo: leftAnchor, constant: insets.left).isActive = true
            subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom).isActive = true
            subview.rightAnchor.constraint(equalTo: rightAnchor, constant: -insets.right).isActive = true
        }
    }

    @objc
    func removeAllSubviews() {
        let all = subviews
        for sub in all {
            sub.removeFromSuperview()
        }
    }

    func setMaskByRounding(corners: UIRectCorner,
                           cornerRadii: CGSize) {
        let rounded = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)

        let shape = CAShapeLayer()
        shape.path = rounded.cgPath
        layer.mask = shape
    }

    @objc
    func clearBackground() {
        backgroundColor = .clear
    }

    @objc
    func disableConstraints() {
        translatesAutoresizingMaskIntoConstraints = true
    }

    @objc
    func enableConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func takeScreenshot() -> UIImage {
        return UIGraphicsImageRenderer(size: bounds.size).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}
