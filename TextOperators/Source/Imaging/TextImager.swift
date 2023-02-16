import Foundation
import UIKit

public class TextImager: Equatable, ExpressibleByArrayLiteral {
    private let imagers: [TextImaging]

    public required init(arrayLiteral: TextImaging...) {
        self.imagers = arrayLiteral
    }

    public required init(_ imagings: [TextImaging]) {
        self.imagers = imagings
    }

    public convenience init(_ imagers: TextImaging) {
        self.init([imagers])
    }

    public convenience init(imagers: [TextImager]) {
        let imagings = imagers.reduce([]) { $0 + $1.imagers }
        self.init(imagings)
    }

    public func image(from string: String) -> UIImage? {
        return imagers.lazy.compactMap { $0.image(from: string) }.first
    }

    public static func +(lhs: TextImager, rhs: TextImaging) -> TextImager {
        let combinedValidations = lhs.imagers + [rhs]
        return .init(combinedValidations)
    }

    public static func +(lhs: TextImaging, rhs: TextImager) -> TextImager {
        let combinedValidations = [lhs] + rhs.imagers
        return .init(combinedValidations)
    }

    public static func +(lhs: TextImager, rhs: TextImager) -> TextImager {
        let combinedValidations = lhs.imagers + rhs.imagers
        return .init(combinedValidations)
    }

    public static func ==(lhs: TextImager, rhs: TextImager) -> Bool {
        let lhsIDs = Set(lhs.imagers.map(\.uniqueID))
        let rhsIDs = Set(rhs.imagers.map(\.uniqueID))
        return lhsIDs == rhsIDs
    }
}
