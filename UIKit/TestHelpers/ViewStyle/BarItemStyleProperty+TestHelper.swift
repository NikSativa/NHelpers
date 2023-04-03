import NSpry
import UIKit

import NUIKit

extension BarItemStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UIBarItem) -> Bool {
        switch self {
        case .textColor(let color, let state):
            return isEqual(color, view.titleTextAttributes(for: state)?[.foregroundColor] as? UIColor)
        case .textFont(let font, let state):
            return font == (view.titleTextAttributes(for: state)?[.font] as? UIFont)
        }
    }
}
