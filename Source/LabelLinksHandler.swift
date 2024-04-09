import UIKit

public protocol LabelLink {
    var tappableText: String { get }
}

// MARK: - URL + LabelLink

extension URL: LabelLink {
    public var tappableText: String {
        return absoluteString
    }
}

public final class LabelLinksHandler<Link: LabelLink> {
    public typealias Callback = (_ tappedLinks: Link) -> Void

    public var links: [Link] = []
    public var label: UILabel? {
        willSet {
            label?.isUserInteractionEnabled = true
            if label?.gestureRecognizers?.contains(gestureRecognizer) == true {
                label?.removeGestureRecognizer(gestureRecognizer)
            }

            newValue?.isUserInteractionEnabled = true
            newValue?.addGestureRecognizer(gestureRecognizer)
        }
    }

    public var action: Callback?

    private let gestureRecognizer: UITapGestureRecognizer

    public init() {
        self.gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(tapOnLabel(sender:)))
    }

    deinit {
        if label?.gestureRecognizers?.contains(gestureRecognizer) == true {
            label?.removeGestureRecognizer(gestureRecognizer)
        }
    }

    @objc
    private func tapOnLabel(sender: UITapGestureRecognizer) {
        guard let label, let action else {
            return
        }

        guard sender.state == .ended else {
            return
        }

        let labelText = label.text ?? ""
        guard !links.isEmpty, !labelText.isEmpty else {
            return
        }

        let tapLocation = sender.location(in: label)
        guard let tapIndex = label.indexOfAttributedTextCharacterAtPoint(tapLocation) else {
            return
        }

        for link in links {
            let linkText = link.tappableText
            for ind in labelText.indicesOf(linkText) {
                if ind <= tapIndex, tapIndex < (ind + linkText.count) {
                    action(link)
                    return
                }
            }
        }
    }
}

private extension UILabel {
    /// - returns: index of character (in the attributedText) at point
    func indexOfAttributedTextCharacterAtPoint(_ point: CGPoint) -> Int? {
        guard let attributedText else {
            return nil
        }

        let textStorage = NSTextStorage(attributedString: attributedText)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineBreakMode = lineBreakMode
        layoutManager.addTextContainer(textContainer)

        let index = layoutManager.characterIndex(for: point,
                                                 in: textContainer,
                                                 fractionOfDistanceBetweenInsertionPoints: nil)
        return index
    }
}

private extension String {
    func indicesOf(_ string: String) -> [Int] {
        var indices: [Int] = []
        var searchStartIndex = startIndex

        while searchStartIndex < endIndex,
              let range = range(of: string, range: searchStartIndex..<endIndex),
              !range.isEmpty {
            let index = distance(from: startIndex, to: range.lowerBound)
            indices.append(index)
            searchStartIndex = range.upperBound
        }

        return indices
    }
}
