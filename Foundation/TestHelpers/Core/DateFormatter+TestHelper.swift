import Foundation
import NSpry

extension DateFormatter {
    static func testMake(timeZone: TimeZone = .testMake(),
                         calendar: Calendar = .current) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.calendar = calendar
        formatter.timeZone = timeZone
        return formatter
    }
}
