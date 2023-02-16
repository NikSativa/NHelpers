import UIKit

public protocol StyleProperty: Equatable {}

public protocol ApplicableStyleProperty: StyleProperty {
    associatedtype ViewType
    func apply(to view: ViewType)
}

public class ViewStyle<T: ApplicableStyleProperty>: Equatable, ExpressibleByArrayLiteral {
    public let properties: [T]

    public required init(arrayLiteral: T...) {
        self.properties = arrayLiteral
    }

    public init(_ properties: T...) {
        self.properties = properties
    }

    private init(_ properties: [T]) {
        self.properties = properties
    }

    public func apply(to view: T.ViewType) {
        for styleProperty in properties {
            styleProperty.apply(to: view)
        }
    }

    public static func +=(lhs: inout ViewStyle<T>, rhs: ViewStyle<T>) {
        lhs = ViewStyle<T>(lhs.properties + rhs.properties)
    }

    public static func +(lhs: ViewStyle<T>, rhs: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle<T>(lhs.properties + rhs.properties)
    }

    public static func +=(lhs: inout ViewStyle<T>, rhs: T) {
        lhs = ViewStyle<T>(lhs.properties + [rhs])
    }

    public static func +(lhs: ViewStyle<T>, rhs: T) -> ViewStyle<T> {
        return ViewStyle<T>(lhs.properties + [rhs])
    }

    public static func +(lhs: T, rhs: ViewStyle<T>) -> ViewStyle<T> {
        return ViewStyle<T>([lhs] + rhs.properties)
    }

    public static func ==(lhs: ViewStyle<T>, rhs: ViewStyle<T>) -> Bool {
        return lhs.properties == rhs.properties
    }
}
