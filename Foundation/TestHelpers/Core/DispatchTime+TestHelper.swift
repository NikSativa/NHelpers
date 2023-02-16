import Foundation
import NSpry

extension DispatchTime {
    static func testMake(secondsFromNow interval: Double) -> Self {
        return .now() + interval
    }

    public static func argument(secondsFromNow interval: Double) -> Argument {
        return .validator { value in
            guard let value = value as? DispatchTime else {
                return false
            }

            let fromNow = DispatchTime.testMake(secondsFromNow: interval)
            let diff: dispatch_time_t
            if value > fromNow {
                diff = value.rawValue - fromNow.rawValue
            } else {
                diff = fromNow.rawValue - value.rawValue
            }
            return diff < 1000000
        }
    }
}
