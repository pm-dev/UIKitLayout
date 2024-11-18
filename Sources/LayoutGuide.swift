import UIKit

@MainActor
public struct LayoutGuide<View: UIView> {

    // MARK: Lifecycle

    public init(path: KeyPath<View, some UILayoutGuide>) {
        self.init(path: path.appending(path: \.constrainable))
    }

    init(path: KeyPath<View, any Constrainable>) {
        self.path = path
    }

    // MARK: Internal

    let path: KeyPath<View, any Constrainable>
}

extension LayoutGuide {
    public static var view: Self { LayoutGuide(path: \.constrainable) }
    public static var safeArea: Self { LayoutGuide(path: \.safeAreaLayoutGuide) }
    public static var readableContent: Self { LayoutGuide(path: \.readableContentGuide) }
    public static var margins: Self { LayoutGuide(path: \.layoutMarginsGuide) }
    @available(iOS 15.0, *)
    public static var keyboard: Self { LayoutGuide(path: \.keyboardLayoutGuide) }
}

extension LayoutGuide where View: UIScrollView {
    public static var content: Self { LayoutGuide(path: \.contentLayoutGuide) }
}

extension UIView {
    fileprivate var constrainable: Constrainable { self }
}

extension UILayoutGuide {
    fileprivate var constrainable: Constrainable { self }
}
