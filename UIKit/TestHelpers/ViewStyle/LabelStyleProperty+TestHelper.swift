import NSpry
import UIKit

import NUIKit

extension LabelStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UILabel) -> Bool {
        switch self {
        case .textColor(let color):
            return isEqual(color, view.textColor)
        case .textFont(let font):
            return font == view.font
        case .textAlignment(let alignment):
            return alignment == view.textAlignment
        case .numberOfLines(let numberOfLines):
            return view.numberOfLines == numberOfLines
        case .backgroundColor(let color):
            return isEqual(color, view.backgroundColor)
        }
    }
}
