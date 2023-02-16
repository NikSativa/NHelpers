import Foundation

public extension TextFormatter {
    static func smart(_ formatter: @escaping (String) -> String) -> TextFormatter {
        return [SmartFormatter(formatter: formatter)]
    }
}

private struct SmartFormatter: TextFormatable {
    typealias Formatter = (String) -> String
    private let formatter: Formatter

    init(formatter: @escaping Formatter) {
        self.formatter = formatter
    }

    func formatText(_ string: String) -> String {
        return formatter(string)
    }
}
