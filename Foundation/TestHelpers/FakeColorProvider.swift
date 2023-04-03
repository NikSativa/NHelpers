import NFoundation
import NSpry
import UIKit

public final class FakeColorProvider<Kind: ColorRepresentable>: ColorProviding, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case color = "color(_:)"
    }

    public init() {}

    public func color(_ kind: Kind) -> UIColor {
        return spryify(arguments: kind)
    }
}
