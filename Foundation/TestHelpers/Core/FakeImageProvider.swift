import NSpry
import UIKit

@testable import NFoundation

final class FakeImageProvider<Name: ImageRepresentable>: ImageProviding, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case image = "image(_:)"
        case imageWithTraitCollection = "image(_:compatibleWith:)"
    }

    func image(_ name: Name) -> UIImage {
        return spryify(arguments: name)
    }

    func image(_ name: Name, compatibleWith traitCollection: UITraitCollection) -> UIImage {
        return spryify(arguments: name, traitCollection)
    }
}
