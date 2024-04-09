import SpryKit
import UIKit
import UIKitHelper
import UIKitHelperTestHelpers
import XCTest

final class TextViewStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UITextView = .init()
        var style: ViewStyle<TextViewStyleProperty> = [
            .textColor(.red),
            .textFont(.systemFont(ofSize: 11)),
            .tintColor(.green),
            .borderWidth(11),
            .borderColor(.brown),
            .textContainerInset(.init(top: 10, left: 10, bottom: 10, right: 10)),
            .linkTextAttributes(.white)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .textColor(.green),
            .textFont(.systemFont(ofSize: 22)),
            .tintColor(.yellow),
            .borderWidth(33),
            .borderColor(.black),
            .textContainerInset(.init(top: 30, left: 10, bottom: 10, right: 10)),
            .linkTextAttributes(.magenta)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
