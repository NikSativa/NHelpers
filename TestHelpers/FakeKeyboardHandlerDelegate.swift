import SpryKit
import UIKit
import UIKitHelper

public final class FakeKeyboardHandlerDelegate: KeyboardHandlerDelegate, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case didChangeBottomContentInset = "didChange(bottomContentInset:)"
    }

    public func didChange(bottomContentInset inset: CGFloat) {
        return spryify(arguments: inset)
    }
}
