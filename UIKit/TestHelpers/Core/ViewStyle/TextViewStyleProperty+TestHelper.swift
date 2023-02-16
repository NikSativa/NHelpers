import NSpry
import UIKit

@testable import NUIKit

extension TextViewStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UITextView) -> Bool {
        switch self {
        case .textColor(let color):
            return isEqual(color, view.textColor)
        case .textFont(let font):
            return font == view.font
        case .tintColor(let color):
            return isEqual(color, view.tintColor)
        case .borderWidth(let width):
            return width == view.layer.borderWidth
        case .borderColor(let color):
            return isEqual(view.layer.borderColor.map(UIColor.init(cgColor:)), color)
        case .textContainerInset(let inset):
            return inset == view.textContainerInset
        case .linkTextAttributes(let color):
            return isEqual(color, view.linkTextAttributes[NSAttributedString.Key.foregroundColor] as? UIColor)
        }
    }
}
