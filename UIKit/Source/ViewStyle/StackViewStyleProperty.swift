import UIKit

public enum StackViewStyleProperty: StyleProperty {
    public typealias Axis = NSLayoutConstraint.Axis

    case margins(UIEdgeInsets)
    case spacing(CGFloat)
    case axis(Axis)
}

// MARK: - ApplicableStyleProperty

extension StackViewStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UIStackView) {
        switch self {
        case .margins(let insets):
            view.layoutMargins = insets
            view.isLayoutMarginsRelativeArrangement = true
        case .spacing(let value):
            view.spacing = value
        case .axis(let value):
            view.axis = value
        }
    }
}
