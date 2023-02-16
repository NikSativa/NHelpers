import Foundation
import UIKit

public protocol ColorRepresentable {
    var colorConfiguration: ColorConfig { get }
}

public protocol ColorProviding {
    associatedtype Kind: ColorRepresentable
    func color(_ kind: Kind) -> UIColor
}

public extension ColorProviding {
    func toAny() -> AnyColorProvider<Kind> {
        if let self = self as? AnyColorProvider<Kind> {
            return self
        }

        return AnyColorProvider(self)
    }
}
