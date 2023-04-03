import Foundation
import NFoundation
import NSpry
import UIKit

public final class FakeURLOpener: URLOpening, Spryable {
    public enum ClassFunction: String, StringRepresentable {
        case empty
    }

    public enum Function: String, StringRepresentable {
        case send = "send(_:)"
        case sink = "sink(receiveValue:)"
    }

    public init() {}

    public var completionHandler: SetClosure<Bool>?
    public func open(_ url: URL,
                     options: [UIApplication.OpenExternalURLOptionsKey: Any],
                     completionHandler: @escaping SetClosure<Bool>) {
        self.completionHandler = completionHandler
        return spryify(arguments: url, options, completionHandler)
    }

    public func open(_ url: URL,
                     completionHandler: @escaping SetClosure<Bool>) {
        self.completionHandler = completionHandler
        return spryify(arguments: url, completionHandler)
    }

    public func open(_ url: URL,
                     options: [UIApplication.OpenExternalURLOptionsKey: Any]) {
        completionHandler = nil
        return spryify(arguments: url, options)
    }

    public func open(_ url: URL) {
        completionHandler = nil
        return spryify(arguments: url)
    }
}
