import Foundation
import UIKit

public struct AnyColorProvider<Kind: ColorRepresentable>: ColorProviding {
    private let _color: (_ kind: Kind) -> UIColor

    init<K: ColorProviding>(_ provider: K) where K.Kind == Kind {
        self._color = provider.color
    }

    public func color(_ kind: Kind) -> UIColor {
        return _color(kind)
    }
}
