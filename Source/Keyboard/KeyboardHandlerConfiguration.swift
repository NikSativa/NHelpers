import Foundation
import UIKit

public struct KeyboardHandlerConfiguration: Equatable {
    public let view: UIView
    public let touchView: UIView?
    public weak var delegate: KeyboardHandlerDelegate?
    public let keyboardPadding: CGFloat
    public let animated: Bool
    public let layoutIfNeeded: Bool

    public init(view: UIView,
                touchView: UIView? = nil,
                delegate: KeyboardHandlerDelegate? = nil,
                keyboardPadding: CGFloat = 0,
                animated: Bool = true,
                layoutIfNeeded: Bool = true) {
        self.view = view
        self.touchView = touchView
        self.delegate = delegate
        self.keyboardPadding = keyboardPadding
        self.animated = animated
        self.layoutIfNeeded = layoutIfNeeded
    }

    public static func ==(lhs: KeyboardHandlerConfiguration, rhs: KeyboardHandlerConfiguration) -> Bool {
        return lhs.animated == rhs.animated
            && lhs.layoutIfNeeded == rhs.layoutIfNeeded
            && lhs.delegate === rhs.delegate
            && lhs.view === rhs.view
            && lhs.touchView === rhs.touchView
            && lhs.keyboardPadding == rhs.keyboardPadding
    }
}
