import Foundation
import UIKit

public extension CACornerMask {
    static let all: Self = [
        .layerMaxXMaxYCorner,
        .layerMaxXMinYCorner,
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner
    ]
    static let none: Self = []

    static let top: Self = [
        .layerMinXMinYCorner,
        .layerMaxXMinYCorner
    ]
    static let left: Self = [
        .layerMinXMinYCorner,
        .layerMinXMaxYCorner
    ]
    static let bottom: Self = [
        .layerMinXMaxYCorner,
        .layerMaxXMaxYCorner
    ]
    static let right: Self = [
        .layerMaxXMinYCorner,
        .layerMaxXMaxYCorner
    ]
}
