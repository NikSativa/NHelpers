import Foundation

public extension TimeZone {
    static let utc: TimeZone = {
        if #available(iOS 16, *) {
            return .gmt
        }

        if let timeZone = TimeZone(abbreviation: "UTC") ?? TimeZone(secondsFromGMT: 0) {
            return timeZone
        }
        assertionFailure()
        return .current
    }()
}
