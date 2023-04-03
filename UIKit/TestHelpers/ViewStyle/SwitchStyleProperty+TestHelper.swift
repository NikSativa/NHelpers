import NSpry
import UIKit

import NUIKit

extension SwitchStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UISwitch) -> Bool {
        switch self {
        case .tintColor(let color):
            return isEqual(color, view.tintColor)
        case .thumbTintColor(let color):
            return isEqual(color, view.thumbTintColor)
        case .onTintColor(let color):
            return isEqual(color, view.onTintColor)
        }
    }
}
