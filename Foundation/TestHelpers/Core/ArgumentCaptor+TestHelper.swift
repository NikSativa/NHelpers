import NSpry

public extension ArgumentCaptor {
    subscript<T>(_ index: Int) -> T {
        return getValue(at: index)
    }

    func `is`<T>(_: T.Type, at index: Int = 0) -> Bool {
        let value: T.Type? = getValue(at: index)
        return !value.isNil
    }
}
