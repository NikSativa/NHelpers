import Foundation

public protocol NotificationDispatching {
    typealias Notification = Foundation.Notification
    typealias Name = Notification.Name

    func addObserver(forName name: Name,
                     object obj: Any?,
                     queue: OperationQueue?,
                     using block: @escaping @Sendable (Notification) -> Void) -> NotificationToken

    func post(_ notification: Notification)
    func post(name aName: Name,
              object anObject: Any?,
              userInfo aUserInfo: [AnyHashable: Any]?)
}

public extension NotificationDispatching {
    func addObserver(forName name: Name,
                     object obj: Any? = nil,
                     queue: OperationQueue? = nil,
                     using block: @escaping @Sendable (Notification) -> Void) -> NotificationToken {
        addObserver(forName: name, object: nil, queue: nil, using: block)
    }

    func post(name aName: Name,
              object anObject: Any? = nil,
              userInfo aUserInfo: [AnyHashable: Any]? = nil) {
        post(name: aName, object: anObject, userInfo: aUserInfo)
    }
}

public final class NotificationDispatcher {
    private let notificationCenter: NotificationCenter

    public init(internalNotificationCenter: NotificationCenter = NotificationCenter.default) {
        self.notificationCenter = internalNotificationCenter
    }
}

// MARK: - NotificationDispatching

extension NotificationDispatcher: NotificationDispatching {
    public func addObserver(forName name: Name,
                            object obj: Any?,
                            queue: OperationQueue?,
                            using block: @escaping @Sendable (Notification) -> Void) -> NotificationToken {
        let token = notificationCenter.addObserver(forName: name, object: obj, queue: queue, using: block)
        return .init(token: token)
    }

    public func post(_ notification: Notification) {
        notificationCenter.post(notification)
    }

    public func post(name aName: Name,
                     object anObject: Any?,
                     userInfo aUserInfo: [AnyHashable: Any]?) {
        notificationCenter.post(name: aName, object: anObject, userInfo: aUserInfo)
    }
}

public final class NotificationToken {
    private let token: NSObjectProtocol

    init(token: NSObjectProtocol) {
        self.token = token
    }

    @discardableResult
    public func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, Any?>, on object: Root) -> NotificationToken {
        object[keyPath: keyPath] = self
        return self
    }

    @discardableResult
    public func assign<Root>(to keyPath: ReferenceWritableKeyPath<Root, NotificationToken?>, on object: Root) -> NotificationToken {
        object[keyPath: keyPath] = self
        return self
    }

    public func store<C: RangeReplaceableCollection>(in collection: inout C) where C.Element == NotificationToken {
        collection.append(self)
    }

    deinit {
        NotificationCenter.default.removeObserver(token)
    }
}
