import UIKit

public enum NavigationBarStyleProperty: StyleProperty {
    case titleColor(UIColor)
    case titleFont(UIFont)
    case backgroundColor(UIColor)
    case tintColor(UIColor)
    case barTintColor(UIColor)
    case isTranslucent(Bool)
    case shadowImage(UIImage?)
    case backgroundImage(UIImage?, state: UIBarMetrics)
}

// MARK: - ApplicableStyleProperty

extension NavigationBarStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UINavigationBar) {
        switch self {
        case .titleColor(let color):
            var textAttributes: [NSAttributedString.Key: Any] = view.titleTextAttributes ?? [:]
            textAttributes[NSAttributedString.Key.foregroundColor] = color
            view.titleTextAttributes = textAttributes
        case .titleFont(let font):
            var textAttributes: [NSAttributedString.Key: Any] = view.titleTextAttributes ?? [:]
            textAttributes[NSAttributedString.Key.font] = font
            view.titleTextAttributes = textAttributes
        case .backgroundColor(let color):
            view.backgroundColor = color
        case .tintColor(let value):
            view.tintColor = value
        case .barTintColor(let value):
            view.barTintColor = value
        case .isTranslucent(let value):
            view.isTranslucent = value
        case .shadowImage(let value):
            view.shadowImage = value
        case .backgroundImage(let value, let state):
            view.setBackgroundImage(value, for: state)
        }
    }
}
