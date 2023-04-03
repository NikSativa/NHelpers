import Foundation
import NSpry

public extension DateFormatter {
    static func testMake(timeZone: TimeZone = .spry.testMake(),
                         calendar: Calendar = .current) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        return formatter
    }
}
