import UIKit

public enum ViewStyleProperty: StyleProperty {
    case backgroundColor(UIColor)
    case border(UIColor, CGFloat)
    case shadow(radius: CGFloat, opacity: Float, offset: CGSize, color: UIColor)
    case cornerRadius(CGFloat)
    case clipsToBounds(Bool)
    case tintColor(UIColor)
}

// MARK: - ApplicableStyleProperty

extension ViewStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UIView) {
        switch self {
        case .backgroundColor(let color):
            view.backgroundColor = color
        case .border(let color, let width):
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = width
        case .shadow(let radius, let opacity, let offset, let color):
            view.layer.shadowRadius = radius
            view.layer.shadowOpacity = opacity
            view.layer.shadowOffset = offset
            view.layer.shadowColor = color.cgColor
        case .cornerRadius(let radius):
            view.layer.cornerRadius = radius
        case .clipsToBounds(let clips):
            view.clipsToBounds = clips
        case .tintColor(let color):
            view.tintColor = color
        }
    }
}
