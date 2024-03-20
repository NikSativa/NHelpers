import Foundation
import NSpry
import UIKit

import NUIKit

extension UIColor: SpryFriendlyStringConvertible {
    public var friendlyDescription: String {
        return "<UIColor " + String(format: "%08X", components.hex) + ">"
    }
}
