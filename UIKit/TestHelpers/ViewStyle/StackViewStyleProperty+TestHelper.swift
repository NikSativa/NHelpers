import NSpry
import UIKit

import NUIKit

extension StackViewStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UIStackView) -> Bool {
        switch self {
        case .margins(let value):
            return view.layoutMargins == value && view.isLayoutMarginsRelativeArrangement
        case .spacing(let value):
            return view.spacing == value
        case .axis(let value):
            return view.axis == value
        }
    }
}
