import UIKit

@MainActor
public struct DimensionRelation<FromView: UIView, ToView: UIView> {

    // MARK: Lifecycle

    public init(
        _ fromDimension: Dimension,
        _ fromLayoutGuide: LayoutGuide<FromView> = .view,
        to toDimension: Dimension,
        _ toLayoutGuide: LayoutGuide<ToView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        multiplier: CGFloat = 1,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) {
        self.fromDimension = fromDimension
        self.fromLayoutGuide = fromLayoutGuide
        self.toDimension = toDimension
        self.toLayoutGuide = toLayoutGuide
        self.multiplier = multiplier
        self.constant = constant
        self.relation = relation
        self.priority = priority
        self.active = active
    }

    // MARK: Public

    public let fromDimension: Dimension
    public let fromLayoutGuide: LayoutGuide<FromView>
    public let toDimension: Dimension
    public let toLayoutGuide: LayoutGuide<ToView>
    public let constant: CGFloat
    public let multiplier: CGFloat
    public let relation: NSLayoutConstraint.Relation
    public let priority: UILayoutPriority
    public let active: Bool

    public func constraint(from fromView: FromView, to toView: ToView) -> NSLayoutConstraint {
        fromView.anchor(dimension: fromDimension, layoutGuide: fromLayoutGuide).pin(
            to: toView.anchor(dimension: toDimension, layoutGuide: toLayoutGuide),
            relation,
            ratio: multiplier,
            plus: constant,
            priority: priority,
            activate: active
        )
    }
}
