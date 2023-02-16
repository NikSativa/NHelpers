import Foundation
import UIKit

public struct AnyImageProvider<Name: ImageRepresentable>: ImageProviding {
    private let _image: (_ name: Name) -> UIImage
    private let _imageTraitCollection: (_ name: Name, _ traitCollection: UITraitCollection) -> UIImage

    init<U: ImageProviding>(_ base: U) where U.Name == Name {
        self._image = { name in
            return base.image(name)
        }

        self._imageTraitCollection = { name, traitCollection in
            return base.image(name, compatibleWith: traitCollection)
        }
    }

    public func image(_ name: Name) -> UIImage {
        return _image(name)
    }

    public func image(_ name: Name, compatibleWith traitCollection: UITraitCollection) -> UIImage {
        return _imageTraitCollection(name, traitCollection)
    }
}
