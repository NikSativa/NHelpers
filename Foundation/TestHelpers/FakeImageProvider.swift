import NFoundation
import NSpry
import UIKit

public final class FakeImageProvider<Name: ImageRepresentable>: ImageProviding, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case image = "image(_:)"
        case imageWithTraitCollection = "image(_:compatibleWith:)"
    }

    public init() {}

    public func image(_ name: Name) -> UIImage {
        return spryify(arguments: name)
    }

    public func image(_ name: Name, compatibleWith traitCollection: UITraitCollection) -> UIImage {
        return spryify(arguments: name, traitCollection)
    }
}
