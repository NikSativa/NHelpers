import UIKit

public enum LabelStyleProperty: StyleProperty {
    case textColor(UIColor)
    case backgroundColor(UIColor)
    case textFont(UIFont)
    case textAlignment(NSTextAlignment)
    case numberOfLines(Int)
}

// MARK: - ApplicableStyleProperty

extension LabelStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UILabel) {
        switch self {
        case .textColor(let color):
            view.textColor = color
        case .textFont(let font):
            view.font = font
        case .textAlignment(let alignment):
            view.textAlignment = alignment
        case .numberOfLines(let numberOfLines):
            view.numberOfLines = numberOfLines
        case .backgroundColor(let color):
            view.backgroundColor = color
        }
    }
}
