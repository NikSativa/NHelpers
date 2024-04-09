import UIKit

public enum ImageViewStyleProperty: StyleProperty {
    case tintColor(UIColor)
    case borderColor(UIColor)
    case borderWidth(CGFloat)
    case contentMode(UIView.ContentMode)
    case cornerRadius(CGFloat)
    case clipsToBounds(Bool)
}

// MARK: - ApplicableStyleProperty

extension ImageViewStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UIImageView) {
        switch self {
        case .tintColor(let color):
            view.tintColor = color
        case .borderColor(let color):
            view.layer.borderColor = color.cgColor
        case .borderWidth(let width):
            view.layer.borderWidth = width
        case .contentMode(let mode):
            view.contentMode = mode
        case .cornerRadius(let radius):
            view.layer.cornerRadius = radius
        case .clipsToBounds(let clips):
            view.clipsToBounds = clips
        }
    }
}
