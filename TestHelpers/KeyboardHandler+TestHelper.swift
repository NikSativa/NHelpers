import Foundation
import SpryKit
import UIKit

import UIKitHelper

public extension KeyboardHandlerConfiguration {
    enum Constant {
        public static let sharedView = UIView()
    }

    static func testMake(view: UIView = Constant.sharedView,
                         touchView: UIView? = nil,
                         delegate: KeyboardHandlerDelegate? = nil,
                         keyboardPadding: CGFloat = 0,
                         animated: Bool = true,
                         layoutIfNeeded: Bool = true) -> KeyboardHandlerConfiguration {
        return KeyboardHandlerConfiguration(view: view,
                                            touchView: touchView,
                                            delegate: delegate,
                                            keyboardPadding: keyboardPadding,
                                            animated: animated,
                                            layoutIfNeeded: layoutIfNeeded)
    }
}
