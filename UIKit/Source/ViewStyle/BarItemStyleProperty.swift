import UIKit

public enum BarItemStyleProperty: StyleProperty {
    case textColor(UIColor, UIControl.State)
    case textFont(UIFont, UIControl.State)
}

// MARK: - ApplicableStyleProperty

extension BarItemStyleProperty: ApplicableStyleProperty {
    public func apply(to view: UIBarItem) {
        let controlState = controlState()
        var textAttributes: [NSAttributedString.Key: Any] = view.titleTextAttributes(for: controlState) ?? [:]

        switch self {
        case .textColor(let color, _):
            textAttributes[.foregroundColor] = color
        case .textFont(let font, _):
            textAttributes[.font] = font
        }

        view.setTitleTextAttributes(textAttributes, for: controlState)
    }

    private func controlState() -> UIControl.State {
        switch self {
        case .textColor(_, let textColorState):
            return textColorState
        case .textFont(_, let textFontState):
            return textFontState
        }
    }
}
