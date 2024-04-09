import SpryKit
import UIKit
import UIKitHelper
import UIKitHelperTestHelpers
import XCTest

final class ButtonStylePropertyTests: XCTestCase {
    func test_spec() {
        let view: UIButton = .init(type: .custom)
        var style: ViewStyle<ButtonStyleProperty> = [
            .titleColor(.red, .normal),
            .backgroundColor(.blue),
            .tintColor(.green),
            .textFont(.systemFont(ofSize: 11)),
            .border(10, .yellow),
            .image(.testMake(.three), .normal),
            .backgroundImage(.testMake(.four), .normal),
            .cornerRadius(2),
            .clipsToBounds(true)
        ]
        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)

        style = [
            .titleColor(.green, .normal),
            .backgroundColor(.yellow),
            .tintColor(.white),
            .textFont(.systemFont(ofSize: 22)),
            .border(11, .brown),
            .image(.testMake(.one), .normal),
            .backgroundImage(.testMake(.two), .normal),
            .cornerRadius(4),
            .clipsToBounds(false)
        ]

        style.apply(to: view)
        XCTAssertStyle(style, beAppliedTo: view)
    }
}
