import NSpry
import UIKit

import NUIKit

extension PageControlStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UIPageControl) -> Bool {
        switch self {
        case .pageIndicatorTintColor(let color):
            return isEqual(color, view.pageIndicatorTintColor)
        case .currentPageIndicatorTintColor(let color):
            return isEqual(color, view.currentPageIndicatorTintColor)
        }
    }
}
