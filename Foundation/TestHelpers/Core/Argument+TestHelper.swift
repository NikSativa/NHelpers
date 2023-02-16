import NSpry

public extension Argument {
    static func type<T>(_: T.Type) -> Self {
        return .validator {
            return ($0 as? T.Type) != nil
        }
    }
}
