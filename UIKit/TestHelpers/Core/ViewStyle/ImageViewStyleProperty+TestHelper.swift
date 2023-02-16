import NSpry
import UIKit

@testable import NUIKit

extension ImageViewStyleProperty: StylePropertyTestable {
    public func isApplied(to view: UIImageView) -> Bool {
        switch self {
        case .tintColor(let color):
            return isEqual(color, view.tintColor)
        case .borderColor(let color):
            return isEqual(view.layer.borderColor.map(UIColor.init(cgColor:)), color)
        case .borderWidth(let width):
            return view.layer.borderWidth == width
        case .clipsToBounds(let value):
            return view.clipsToBounds == value
        case .contentMode(let mode):
            return view.contentMode == mode
        case .cornerRadius(let radius):
            return view.layer.cornerRadius == radius
        }
    }
}
