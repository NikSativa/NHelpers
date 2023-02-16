import Foundation
import UIKit

public struct BaseImageProvider<Name: ImageRepresentable> {
    private let bundle: Bundle

    public init(bundle: Bundle = .main) {
        self.bundle = bundle
    }
}

// MARK: - ImageProviding

extension BaseImageProvider: ImageProviding {
    public func image(_ name: Name) -> UIImage {
        return image(named: name,
                     compatibleWith: nil)
    }

    public func image(_ name: Name,
                      compatibleWith traitCollection: UITraitCollection) -> UIImage {
        return image(named: name,
                     compatibleWith: traitCollection)
    }

    private func image(named name: Name,
                       compatibleWith traitCollection: UITraitCollection?) -> UIImage {
        let image = UIImage(named: name.rawValue,
                            in: bundle,
                            compatibleWith: traitCollection)
        return image ?? .init()
    }
}
