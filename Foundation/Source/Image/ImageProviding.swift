import Foundation
import UIKit

public protocol ImageRepresentable: Hashable, RawRepresentable where RawValue == String {}

public protocol ImageProviding {
    associatedtype Name: ImageRepresentable

    func image(_ name: Name) -> UIImage
    func image(_ name: Name, compatibleWith traitCollection: UITraitCollection) -> UIImage
}

public extension ImageProviding {
    func toAny() -> AnyImageProvider<Name> {
        if let self = self as? AnyImageProvider<Name> {
            return self
        }

        return AnyImageProvider(self)
    }
}
