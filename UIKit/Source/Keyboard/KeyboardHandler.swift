import Foundation
import NFoundation
import UIKit

public protocol KeyboardHandlerDelegate: AnyObject {
    func didChange(bottomContentInset inset: CGFloat)
}

public final class KeyboardHandler {
    private let transparentTouchView: TransparentTouchView
    private let notificationCenter: NotificationDispatching
    private var configuration: KeyboardHandlerConfiguration?
    private var observers: [NotificationToken] = []
    private var animated: Bool {
        return configuration?.animated == true
    }

    public init(notificationCenter: NotificationDispatching,
                transparentTouchView: TransparentTouchView) {
        self.notificationCenter = notificationCenter
        self.transparentTouchView = transparentTouchView

        notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification) { [unowned self] in
            keyboardWillShow($0)
        }.store(in: &observers)

        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification) { [unowned self] in
            keyboardWillHide($0)
        }.store(in: &observers)
    }

    deinit {
        transparentTouchView.removeFromSuperview()
    }
}

// MARK: - KeyboardHandling

extension KeyboardHandler: KeyboardHandling {
    public func enable(for configuration: KeyboardHandlerConfiguration, excluded: ExcludedViews?) {
        assert(self.configuration == nil, "dual initialization")
        self.configuration = configuration

        transparentTouchView.callback = { [weak self] in
            self?.configuration?.view.endEditing(true)
        }

        transparentTouchView.excluded = {
            return excluded?() ?? []
        }
    }

    private func animate(notification: Notification, _ newBottomInsetPlusKeyboardPadding: CGFloat) {
        if animated,
           let view = configuration?.view,
           let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
           let curve = notification.userInfo?[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt {
            view.setNeedsLayout()
            UIView.animate(withDuration: duration,
                           delay: 0,
                           options: UIView.AnimationOptions(rawValue: curve),
                           animations: ({ [weak self] in
                               self?.configuration?.delegate?.didChange(bottomContentInset: newBottomInsetPlusKeyboardPadding)

                               if self?.configuration?.layoutIfNeeded == true {
                                   self?.configuration?.view.layoutIfNeeded()
                               }
                           }),
                           completion: nil)
        } else {
            configuration?.delegate?.didChange(bottomContentInset: newBottomInsetPlusKeyboardPadding)
        }
    }

    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let configuration = configuration else {
            return
        }

        if let touchView = configuration.touchView {
            touchView.addAndFill(transparentTouchView)
            transparentTouchView.widthAnchor.constraint(equalTo: touchView.widthAnchor).isActive = true
            transparentTouchView.heightAnchor.constraint(equalTo: touchView.heightAnchor).isActive = true
            touchView.bringSubviewToFront(transparentTouchView)
        }

        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }

        let view = configuration.view
        let keyboardSize = keyboardValue.cgRectValue.size
        let viewRectFlattened = view.convert(view.bounds, to: nil)

        let bottomOfViewYPos = viewRectFlattened.origin.y + viewRectFlattened.size.height
        let bottomOfScreenYPos = UIScreen.main.bounds.height
        let distanceBetweenBottomOfScreenAndView = bottomOfScreenYPos - bottomOfViewYPos
        let newBottomInset = keyboardSize.height - distanceBetweenBottomOfScreenAndView
        let newBottomInsetPlusKeyboardPadding = newBottomInset + configuration.keyboardPadding

        if let scrollView = view as? UIScrollView {
            scrollView.contentInset.bottom = newBottomInsetPlusKeyboardPadding
            if #available(iOS 13, *) {
                scrollView.verticalScrollIndicatorInsets.bottom = newBottomInset
            } else {
                scrollView.scrollIndicatorInsets.bottom = newBottomInset
            }
        }

        animate(notification: notification, newBottomInsetPlusKeyboardPadding)
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        if let scrollView = configuration?.view as? UIScrollView {
            // If you find that your view is jumping to the top of the view after you hide the keyboard:
            // 1. Go into your xib
            // 2. Select the view controller that contains the UIScrollView
            // 3. Go to Attributes Inspector
            // 4. Uncheck the option 'Adjust Scroll View Inset'
            scrollView.contentInset = .zero
            scrollView.scrollIndicatorInsets = .zero

            // Force invalidate the ScrollView
            scrollView.setContentOffset(scrollView.contentOffset, animated: true)
        }

        animate(notification: notification, 0)

        transparentTouchView.removeFromSuperview()
    }
}
