import NSpry
import UIKit

import NUIKit

final class FakeKeyboardHandlerDelegate: KeyboardHandlerDelegate, Spryable {
    enum ClassFunction: String, StringRepresentable {
        case empty
    }

    enum Function: String, StringRepresentable {
        case didChangeBottomContentInset = "didChange(bottomContentInset:)"
    }

    func didChange(bottomContentInset inset: CGFloat) {
        return spryify(arguments: inset)
    }
}
