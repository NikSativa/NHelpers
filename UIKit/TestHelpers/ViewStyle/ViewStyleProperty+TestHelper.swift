import NSpry
import UIKit

import NUIKit

extension ViewStyleProperty: StylePropertyTestable {
    public static func ==(lhs: ViewStyleProperty, rhs: ViewStyleProperty) -> Bool {
        switch (lhs, rhs) {
        case (.backgroundColor(let color), .backgroundColor(let color1)):
            return isEqual(color, color1)
        case (.border(let color, let width), .border(let color1, let width1)):
            return isEqual(color, color1) && width == width1
        case (.shadow(let radius, let opacity, let offset, let color1), .shadow(let radius1, let opacity1, let offset1, let color2)):
            return isEqual(color1, color2) && radius == radius1 && opacity == opacity1 && offset == offset1
        case (.cornerRadius(let radius), .cornerRadius(let radius1)):
            return radius == radius1
        case (.clipsToBounds(let clips), .clipsToBounds(let clips1)):
            return clips == clips1
        case (.tintColor(let color1), .tintColor(let color2)):
            return isEqual(color1, color2)
        case (.backgroundColor, _),
             (.border, _),
             (.clipsToBounds, _),
             (.cornerRadius, _),
             (.shadow, _),
             (.tintColor, _):
            return false
        }
    }

    public func isApplied(to view: UIView) -> Bool {
        switch self {
        case .backgroundColor(let color):
            return isEqual(color, view.backgroundColor)
        case .border(let color, let width):
            return isEqual(view.layer.borderColor.map(UIColor.init(cgColor:)), color) && view.layer.borderWidth == width
        case .shadow(let radius, let opacity, let offset, let color):
            return view.layer.shadowRadius == radius
                && view.layer.shadowOpacity == opacity
                && view.layer.shadowOffset == offset
                && isEqual(view.layer.shadowColor.map(UIColor.init(cgColor:)), color)
        case .cornerRadius(let radius):
            return view.layer.cornerRadius == radius
        case .clipsToBounds(let clips):
            return view.clipsToBounds == clips
        case .tintColor(let color):
            return isEqual(color, view.tintColor)
        }
    }
}
