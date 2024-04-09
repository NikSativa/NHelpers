import Foundation
import UIKit

public enum GradientViewStyleProperty: StyleProperty {
    case startPoint(CGPoint)
    case endPoint(CGPoint)
    case locations([Double])
    case colors([UIColor])
    case type(CAGradientLayerType)
}

// MARK: - ApplicableStyleProperty

extension GradientViewStyleProperty: ApplicableStyleProperty {
    public func apply(to view: GradientView) {
        switch self {
        case .startPoint(let value):
            view.layer.startPoint = value
        case .endPoint(let value):
            view.layer.endPoint = value
        case .colors(let value):
            view.layer.colors = value.map(\.cgColor)
        case .locations(let value):
            view.layer.locations = value.map(NSNumber.init(value:))
        case .type(let value):
            view.layer.type = value
        }
    }
}
