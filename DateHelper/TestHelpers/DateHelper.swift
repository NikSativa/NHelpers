import Foundation

@testable import DateHelper

public extension DateHelper {
    convenience init(fakeDateProvider dateProvider: FakeDateSettingsProvider) {
        self.init(dateProvider: dateProvider)
    }
}
