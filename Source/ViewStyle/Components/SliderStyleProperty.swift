import UIKit

public enum SliderStyleProperty: StyleProperty {
    case tintColor(UIColor)
    case thumbTintColor(UIColor)
    case minimumTrackTintColor(UIColor)
    case maximumTrackTintColor(UIColor)
}

// MARK: - ApplicableStyleProperty

extension SliderStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UISlider) {
        switch self {
        case .tintColor(let color):
            view.tintColor = color
        case .thumbTintColor(let color):
            view.thumbTintColor = color
        case .minimumTrackTintColor(let color):
            view.minimumTrackTintColor = color
        case .maximumTrackTintColor(let color):
            view.maximumTrackTintColor = color
        }
    }
}
