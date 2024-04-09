import SpryKit
import UIKit
import UIKitHelper

extension NavigationBarStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UINavigationBar) -> Bool {
        let textAttributes: [NSAttributedString.Key: Any]? = view.titleTextAttributes

        switch self {
        case .titleColor(let color):
            return isEqual(color, textAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor)
        case .titleFont(let font):
            return font == (textAttributes?[NSAttributedString.Key.font] as? UIFont)
        case .backgroundColor(let color):
            return isEqual(color, view.backgroundColor)
        case .tintColor(let color):
            return isEqual(color, view.tintColor)
        case .barTintColor(let color):
            return isEqual(color, view.barTintColor)
        case .isTranslucent(let value):
            return view.isTranslucent == value
        case .shadowImage(let image):
            return isEqual(image, view.shadowImage)
        case .backgroundImage(let image, let state):
            return isEqual(image, view.backgroundImage(for: state))
        }
    }
}
