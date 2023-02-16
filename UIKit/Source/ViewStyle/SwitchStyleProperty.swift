import UIKit

public enum SwitchStyleProperty: StyleProperty {
    case tintColor(UIColor)
    case thumbTintColor(UIColor)
    case onTintColor(UIColor)
}

// MARK: - ApplicableStyleProperty

extension SwitchStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UISwitch) {
        switch self {
        case .tintColor(let color):
            view.tintColor = color
        case .thumbTintColor(let color):
            view.thumbTintColor = color
        case .onTintColor(let color):
            view.onTintColor = color
        }
    }
}
