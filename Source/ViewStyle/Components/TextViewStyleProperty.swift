import UIKit

public enum TextViewStyleProperty: StyleProperty {
    case textColor(UIColor)
    case textFont(UIFont)
    case tintColor(UIColor)
    case borderWidth(CGFloat)
    case borderColor(UIColor)
    case textContainerInset(UIEdgeInsets)
    case linkTextAttributes(UIColor)
}

// MARK: - ApplicableStyleProperty

extension TextViewStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UITextView) {
        switch self {
        case .textColor(let color):
            view.textColor = color
        case .textFont(let font):
            view.font = font
        case .tintColor(let color):
            view.tintColor = color
        case .borderWidth(let width):
            view.layer.borderWidth = width
        case .borderColor(let color):
            view.layer.borderColor = color.cgColor
        case .textContainerInset(let inset):
            view.textContainerInset = inset
        case .linkTextAttributes(let color):
            view.linkTextAttributes = [.foregroundColor: color]
        }
    }
}
