import UIKit

public enum TextFieldStyleProperty: StyleProperty {
    case backgroundColor(UIColor)
    case tintColor(UIColor)
    case textColor(UIColor)
    case textFont(UIFont)
    case borderStyle(UITextField.BorderStyle)
}

// MARK: - ApplicableStyleProperty

extension TextFieldStyleProperty: ApplicableStyleProperty {
    public typealias ViewType = UITextField

    public func apply(to view: ViewType) {
        switch self {
        case .backgroundColor(let color):
            view.backgroundColor = color
        case .tintColor(let color):
            view.tintColor = color
        case .textColor(let color):
            view.textColor = color
        case .textFont(let font):
            view.font = font
        case .borderStyle(let style):
            view.borderStyle = style
        }
    }
}
