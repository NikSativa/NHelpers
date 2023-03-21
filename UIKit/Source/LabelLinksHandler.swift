import NFoundation
import UIKit

public final class LabelLinksHandler {
    private let label: UILabel!
    private let links: Set<URL>!
    private let gestureRecognizer: UITapGestureRecognizer!
    private let action: (URL) -> Void

    public init(label: UILabel,
                links: Set<URL>,
                action: @escaping (_ link: URL) -> Void) {
        self.label = label
        self.links = links
        self.action = action
        self.gestureRecognizer = UITapGestureRecognizer()

        gestureRecognizer.addTarget(self, action: #selector(tapOnLabel(sender:)))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(gestureRecognizer)
    }

    deinit {
        if label.gestureRecognizers?.contains(gestureRecognizer) == true {
            label.removeGestureRecognizer(gestureRecognizer)
        }
    }

    @objc
    private func tapOnLabel(sender: UITapGestureRecognizer) {
        let labelText = label.text ?? ""
        guard !links.isEmpty, !labelText.isEmpty else {
            return
        }

        let tapLocation = sender.location(in: label)
        guard let tapIndex = label.indexOfAttributedTextCharacterAtPoint(tapLocation) else {
            return
        }

        for link in links {
            let linkText = link.absoluteString
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
