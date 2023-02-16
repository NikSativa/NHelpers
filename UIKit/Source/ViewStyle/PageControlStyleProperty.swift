import UIKit

public enum PageControlStyleProperty: StyleProperty {
    case pageIndicatorTintColor(UIColor)
    case currentPageIndicatorTintColor(UIColor)
}

// MARK: - ApplicableStyleProperty

extension PageControlStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UIPageControl) {
        switch self {
        case .pageIndicatorTintColor(let color):
            view.pageIndicatorTintColor = color
        case .currentPageIndicatorTintColor(let color):
            view.currentPageIndicatorTintColor = color
        }
    }
}
