import Foundation
import NSpry

extension TimeZone: SpryEquatable {
    static func testMake(secondsFromGMT: Int = 0) -> Self {
        TimeZone(secondsFromGMT: secondsFromGMT)!
    }
}
