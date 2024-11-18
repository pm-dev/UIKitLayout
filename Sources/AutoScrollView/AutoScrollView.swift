import Foundation
import UIKit

/**
 Getting constraints right with a UIScrollView can be very tricky.
 This class adapts the scroll view to behave in a simple and commonly desired way.

 You can use this class as you normally would any other UIView. The difference comes from
 the scrollableDimensions parameter passed on init. If you set `width` or `height` as scrollable,
 that dimension's content will be allowed to flow off screen and the user will be able to scroll to
 that offscreen content.

 This approach is found at:
 https://developer.apple.com/
 library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html
 */
open class AutoScrollView: UIScrollView {

    // MARK: Lifecycle

    public init(scrollableDimensions: Set<Dimension>) {
        super.init(frame: .zero)
        didInstantiate(scrollableDimensions: scrollableDimensions)
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInstantiate(scrollableDimensions: [.width, .height])
    }

    // MARK: Public

    @available(*, unavailable, message: "This view does not support adjusted content inset")
    override public var contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior {
        get { .never }
        set { _ = newValue }
    }

    override public func addSubview(_ view: UIView) {
        contentView.addSubview(view)
    }

    // MARK: Private

    private let contentView = UIView()

    private func didInstantiate(scrollableDimensions: Set<Dimension>) {
        super.contentInsetAdjustmentBehavior = .never
        super.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        top.pin(to: contentView.top)
        leading.pin(to: contentView.leading)
        trailing.pin(to: contentView.trailing)
        bottom.pin(to: contentView.bottom)
        if !scrollableDimensions.contains(.width) {
            width.pin(to: contentView.width)
        }
        if !scrollableDimensions.contains(.height) {
            height.pin(to: contentView.height)
        }
    }
}
