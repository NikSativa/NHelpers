import Foundation

public extension Date {
    static func testMake(year: Int = 0,
                         month: Int = 0,
                         day: Int = 0,
                         hour: Int = 0,
                         minute: Int = 0,
                         second: Int = 0,
                         nanosecond: Int = 0,
                         timeZone: TimeZone = .testMake(),
                         calendar: Calendar = .current) -> Self {
        let components = DateComponents(calendar: calendar,
                                        timeZone: timeZone,
                                        year: year,
                                        month: month,
                                        day: day,
                                        hour: hour,
                                        minute: minute,
                                        second: second,
                                        nanosecond: nanosecond)
        guard let date = calendar.date(from: components) else {
            fatalError("Date.testMake() has invalid parameters")
        }
        return date
    }
}
