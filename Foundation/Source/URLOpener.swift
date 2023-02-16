import Foundation
import UIKit

public protocol URLOpening {
    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any],
              completionHandler: @escaping SetClosure<Bool>)
    func open(_ url: URL,
              completionHandler: @escaping SetClosure<Bool>)
    func open(_ url: URL,
              options: [UIApplication.OpenExternalURLOptionsKey: Any])
    func open(_ url: URL)
}

public final class URLOpener {
    private let app: UIApplication

    public init(app: UIApplication) {
        self.app = app
    }

    private func open(url: URL,
                      options: [UIApplication.OpenExternalURLOptionsKey: Any] = [:],
                      completionHandler: SetClosure<Bool>? = nil) {
        if app.canOpenURL(url) {
            app.open(url,
                     options: options,
                     completionHandler: completionHandler)
        } else {
            completionHandler?(false)
        }
    }
}

// MARK: - URLOpening

extension URLOpener: URLOpening {
    public func open(_ url: URL,
                     options: [UIApplication.OpenExternalURLOptionsKey: Any],
                     completionHandler: @escaping SetClosure<Bool>) {
        open(url: url,
             options: options,
             completionHandler: completionHandler)
    }

    public func open(_ url: URL,
                     completionHandler: @escaping SetClosure<Bool>) {
        open(url: url,
             completionHandler: completionHandler)
    }

    public func open(_ url: URL,
                     options: [UIApplication.OpenExternalURLOptionsKey: Any]) {
        open(url: url,
             options: options)
    }

    public func open(_ url: URL) {
        open(url: url)
    }
}
