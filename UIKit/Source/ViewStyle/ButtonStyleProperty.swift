import UIKit

public enum ButtonStyleProperty: StyleProperty {
    public typealias ViewState = UIButton.State

    case titleColor(UIColor, ViewState)
    case backgroundColor(UIColor)
    case tintColor(UIColor)
    case textFont(UIFont)
    case border(CGFloat, UIColor)
    case image(UIImage, ViewState)
    case backgroundImage(UIImage, ViewState)
    case cornerRadius(CGFloat)
    case clipsToBounds(Bool)
}

// MARK: - ApplicableStyleProperty

extension ButtonStyleProperty: ApplicableStyleProperty {
    public typealias ViewType = UIButton

    public func apply(to view: ViewType) {
        switch self {
        case .titleColor(let color, let controlState):
            view.setTitleColor(color, for: controlState)
        case .backgroundColor(let color):
            view.backgroundColor = color
        case .tintColor(let color):
            view.tintColor = color
        case .textFont(let font):
            view.titleLabel?.font = font
        case .border(let width, let color):
            view.layer.borderColor = color.cgColor
            view.layer.borderWidth = width
        case .image(let image, let state):
            view.setImage(image, for: state)
        case .backgroundImage(let image, let state):
            view.setBackgroundImage(image, for: state)
        case .cornerRadius(let radius):
            view.layer.cornerRadius = radius
        case .clipsToBounds(let value):
            view.clipsToBounds = value
        }
    }
}
