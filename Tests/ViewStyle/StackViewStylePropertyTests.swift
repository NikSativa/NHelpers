import SpryKit
import UIKit
import UIKitHelper
import UIKitHelperTestHelpers
import XCTest

final class StackViewStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UIStackView = .init()
        var style: ViewStyle<StackViewStyleProperty> = [
            .margins(.init(top: 1, left: 1, bottom: 1, right: 1)),
            .spacing(10),
            .axis(.vertical)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .margins(.init(top: 2, left: 2, bottom: 2, right: 2)),
            .spacing(22),
            .axis(.horizontal)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
