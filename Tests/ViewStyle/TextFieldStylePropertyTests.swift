import SpryKit
import UIKit
import UIKitHelper
import UIKitHelperTestHelpers
import XCTest

final class TextFieldStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UITextField = .init()
        var style: ViewStyle<TextFieldStyleProperty> = [
            .backgroundColor(.yellow),
            .textColor(.red),
            .textFont(.systemFont(ofSize: 11)),
            .borderStyle(.line)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .backgroundColor(.white),
            .textColor(.black),
            .textFont(.systemFont(ofSize: 22)),
            .borderStyle(.bezel)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
