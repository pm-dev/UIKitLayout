import UIKit

/**
 XAxisAnchor is used for setting up
 horizontal constraints.
 */
@MainActor
public struct XAxisAnchor {

    // MARK: Public

    public static func left(_ anchor: NSLayoutXAxisAnchor) -> Self {
        .init(anchor: anchor, axis: .left)
    }

    public static func leading(_ anchor: NSLayoutXAxisAnchor) -> Self {
        .init(anchor: anchor, axis: .leading)
    }

    public static func right(_ anchor: NSLayoutXAxisAnchor) -> Self {
        .init(anchor: anchor, axis: .right)
    }

    public static func trailing(_ anchor: NSLayoutXAxisAnchor) -> Self {
        .init(anchor: anchor, axis: .trailing)
    }

    public static func centerX(_ anchor: NSLayoutXAxisAnchor) -> Self {
        .init(anchor: anchor, axis: .centerX)
    }

    @discardableResult
    public func pin(
        to toAnchor: Self,
        _ relation: NSLayoutConstraint.Relation = .equal,
        spacing: CGFloat = 0,
        priority: UILayoutPriority = .required,
        activate: Bool = true
    ) -> NSLayoutConstraint {
        let invert = (axis == .right || axis == .trailing) && (toAnchor.axis == .left || toAnchor.axis == .leading)
        if invert {
            return anchor.pin(
                to: toAnchor.anchor,
                relation.inverse,
                constant: -spacing,
                priority: priority,
                activate: activate
            )
        } else {
            return anchor.pin(
                to: toAnchor.anchor,
                relation,
                constant: spacing,
                priority: priority,
                activate: activate
            )
        }
    }

    // MARK: Internal

    let anchor: NSLayoutXAxisAnchor
    let axis: XAxis
}
