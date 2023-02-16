import NSpry

@testable import NUIKit

extension ViewStyle: SpryEquatable {}

public protocol StylePropertyTestable: ApplicableStyleProperty, SpryEquatable {
    func isApplied(to view: ViewType) -> Bool
}

extension ViewStyle where T: StylePropertyTestable {
    func isApplied<ViewType>(to view: ViewType) -> Bool where ViewType == T.ViewType {
        let failed = properties.first(where: {
            return !$0.isApplied(to: view)
        })
        return failed == nil
    }
}
