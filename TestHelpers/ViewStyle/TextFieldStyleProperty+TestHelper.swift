import SpryKit
import UIKit
import UIKitHelper

extension TextFieldStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UITextField) -> Bool {
        switch self {
        case .textColor(let color):
            return isEqual(color, view.textColor)
        case .textFont(let font):
            return font == view.font
        case .borderStyle(let style):
            return view.borderStyle == style
        case .backgroundColor(let color):
            return isEqual(color, view.backgroundColor)
        case .tintColor(let color):
            return isEqual(color, view.tintColor)
        }
    }
}
