import SpryKit
import UIKit
import UIKitHelper
import UIKitHelperTestHelpers
import XCTest

final class SwitchStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UISwitch = .init()
        var style: ViewStyle<SwitchStyleProperty> = [
            .tintColor(.red),
            .thumbTintColor(.green),
            .onTintColor(.blue)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .tintColor(.white),
            .thumbTintColor(.gray),
            .onTintColor(.black)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
