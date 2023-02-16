import Foundation
import UIKit

public protocol TextImaging {
    var uniqueID: String { get }
    func image(from string: String) -> UIImage?
}

public extension TextImaging {
    var uniqueID: String {
        return makeUniqueID()
    }

    func makeUniqueID() -> String {
        return String(describing: type(of: self))
    }

    static func ==(lhs: Self, rhs: Self) -> Bool {
        return lhs.uniqueID == rhs.uniqueID
    }
}
