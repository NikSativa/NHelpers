import Foundation
import Nimble
import UIKit

@testable import NUIKit

extension UIColor: TestOutputStringConvertible {
    public var testDescription: String {
        return "<UIColor " + String(format: "%08X", components.hex) + ">"
    }
}
