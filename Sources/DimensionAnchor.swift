import UIKit

/**
 DimensionAnchor is used for setting up
 constraints relating specifically to a view's size.
 */
public struct DimensionAnchor {

    // MARK: Public

    @MainActor
    @discardableResult
    public func pin(
        to toAnchor: Self,
        _ relation: NSLayoutConstraint.Relation = .equal,
        ratio: Ratio = .equal,
        plus: CGFloat = 0,
        priority: UILayoutPriority = .required,
        activate: Bool = true
    ) -> NSLayoutConstraint {
        anchor.pin(
            to: toAnchor.anchor,
            relation,
            ratio: ratio,
            plus: plus,
            priority: priority,
            activate: activate
        )
    }

    @MainActor
    @discardableResult
    public func pin(
        _ relation: NSLayoutConstraint.Relation = .equal,
        to constant: CGFloat,
        priority: UILayoutPriority = .required,
        activate: Bool = true
    ) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint
        switch relation {
        case .equal: constraint = anchor.constraint(equalToConstant: constant)
        case .greaterThanOrEqual: constraint = anchor.constraint(greaterThanOrEqualToConstant: constant)
        case .lessThanOrEqual: constraint = anchor.constraint(lessThanOrEqualToConstant: constant)
        @unknown default: fatalError("NSLayoutConstraint.Relation type <\(relation)> unsupported")
        }
        constraint.priority = priority
        constraint.isActive = activate
        return constraint
    }

    // MARK: Internal

    let anchor: NSLayoutDimension
}
