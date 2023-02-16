import NSpry
import UIKit

@testable import NUIKit

extension ButtonStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UIButton) -> Bool {
        switch self {
        case .titleColor(let color, let controlState):
            return isEqual(color, view.titleColor(for: controlState))
        case .backgroundColor(let color):
            return isEqual(color, view.backgroundColor)
        case .tintColor(let color):
            return isEqual(color, view.tintColor)
        case .textFont(let font):
            return font == view.titleLabel?.font
        case .border(let width, let color):
            return isEqual(view.layer.borderColor.map(UIColor.init(cgColor:)), color) && view.layer.borderWidth == width
        case .image(let image, let state):
            return isEqual(image, view.image(for: state))
        case .backgroundImage(let image, let state):
            return isEqual(image, view.backgroundImage(for: state))
        case .cornerRadius(let radius):
            return radius == view.layer.cornerRadius
        case .clipsToBounds(let value):
            return value == view.clipsToBounds
        }
    }
}
