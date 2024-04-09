import SpryKit
import UIKitHelper

public protocol StylePropertyTestable: ApplicableStyleProperty {
    func isApplied(to view: ViewType) -> Bool
}

public extension ViewStyle where T: StylePropertyTestable {
    func isApplied<ViewType>(to view: ViewType) -> Bool where ViewType == T.ViewType {
        return notAppliedProperty(to: view) == nil
    }

    func notAppliedProperty<ViewType>(to view: ViewType) -> T? where ViewType == T.ViewType {
        let failed = properties.first(where: {
            return !$0.isApplied(to: view)
        })
        return failed
    }
}
