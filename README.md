# UIKitHelper

This library is a collection of helper classes and extensions to make UIKit development easier.

### ModalPresenter
ModalPresenter is a class that allows you to present a view controller as a modal view controller.

```swift
let subject: ModalPresenter = .init(appRootViewControllerProvider: ...)
subject.lineUp(modalViewController)
```

### KeyboardHandler
Keyboard Handler is a class that allows you to handle keyboard events and scroll content to a visible position.

```swift
private let keyboardHandler: KeyboardHandler = .init()

override func viewDidLoad() {
    super.viewDidLoad()
    keyboardHandler.enable(for: .init(view: scrollView, touchView: view, keyboardPadding: 16),
                           excluded: { [weak self] in
                               return [self?.emailTextField, self?.passwordTextField].filterNils()
                           })
}

```

### TransparentTouchView
TransparentTouchView allows you to create a view that is transparent to touch events.
The best example is when keyaboard is shown and user want tap some button on the screen. Then this view will handle touch on screen, but not locking touch on button. As result keyboard is hidding and button is pressed.

```swift
private let touchView = TransparentTouchView()

override func viewDidLoad() {
    super.viewDidLoad()
    view.addAndFill(touchView)
    touchView.action = { [weak self] in
        self?.view.endEditing(true)
    }
}
``` 

### LabelLinksHandler 
LabelLinksHandler allows you to detect tap on links in a UILabel.

```swift
@IBOutlet private weak var label: UILabel!
private let linkHandler: LabelLinksHandler<URL> = .init()
override func viewDidLoad() {
    super.viewDidLoad()
    linkHandler.label = label
    linkHandler.action = { [weak self] url in
        print(url)
    }
}

func configure(with viewModel: ViewModel) {
    label.text = viewModel.text
    linkHandler.links = viewModel.urls
}
```

### ViewStyle
ViewStyle is a class that allows you to easily style the UI components that you need.

```swift
let style = [
    .backgroundColor(.blue),
    .border(.magenta, 10),
    .shadow(radius: 20, opacity: 0.9, offset: .init(width: 11, height: 11), color: .black),
    .cornerRadius(12),
    .clipsToBounds(false),
    .tintColor(.white)
]

style.apply(to: viewOne)
style.apply(to: viewTwo)
style.apply(to: viewThree)
```
