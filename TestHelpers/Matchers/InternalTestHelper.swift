import SpryKit
import UIKit

internal func isEqual(_ lhs: UIImage?, _ rhs: UIImage?) -> Bool {
    if lhs == nil, rhs == nil {
        return true
    }

    guard let lhs, let rhs else {
        return false
    }

    if lhs.size == rhs.size {
        return true
    }

    if isAnyEqual(lhs, rhs) {
        return true
    }

    let rgbL = UIGraphicsImageRenderer(size: lhs.size).image { _ in
        lhs.draw(at: .zero)
    }

    let rgbR = UIGraphicsImageRenderer(size: rhs.size).image { _ in
        rhs.draw(at: .zero)
    }

    return rgbL.pngData() == rgbR.pngData()
}

internal func isEqual(_ lhs: UIColor?, _ rhs: UIColor?) -> Bool {
    if lhs == nil, rhs == nil {
        return true
    }

    guard let lhs, let rhs else {
        return false
    }

    if isAnyEqual(lhs, rhs) {
        return true
    }

    return lhs.cgColor == rhs.cgColor
}
