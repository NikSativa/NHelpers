import Foundation

public protocol LinkDetecting {
    func links(inside text: String) -> Set<URL>
}

public struct LinkDetector {
    private let detector: NSDataDetector

    public init() {
        self.detector = try! .init(types: NSTextCheckingResult.CheckingType.link.rawValue)
    }
}

// MARK: - LinkDetecting

extension LinkDetector: LinkDetecting {
    public func links(inside text: String) -> Set<URL> {
        let matches = detector.matches(in: text,
                                       options: [],
                                       range: NSRange(location: 0, length: text.count))
        let result = matches.compactMap { match in
            if let range = Range(match.range, in: text) {
                let link = text[range]
                return URL(string: String(link))
            }
            return nil
        }
        return Set(result)
    }
}
