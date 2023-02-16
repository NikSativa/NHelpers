import NSpry
import UIKit

@testable import NFoundation

final class FakeColorProvider<Kind: ColorRepresentable>: ColorProviding, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case color = "color(_:)"
    }

    func color(_ kind: Kind) -> UIColor {
        return spryify(arguments: kind)
    }
}
