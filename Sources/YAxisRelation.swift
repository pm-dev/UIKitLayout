import UIKit

@MainActor
public struct YAxisRelation<FromView: UIView, ToView: UIView> {

    // MARK: Lifecycle

    public init(
        _ fromAxis: YAxis,
        _ fromLayoutGuide: LayoutGuide<FromView> = .view,
        to toAxis: YAxis,
        _ toLayoutGuide: LayoutGuide<ToView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        constant: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) {
        self.fromAxis = fromAxis
        self.fromLayoutGuide = fromLayoutGuide
        self.toAxis = toAxis
        self.toLayoutGuide = toLayoutGuide
        self.constant = constant
        self.relation = relation
        self.priority = priority
        self.active = active
    }

    // MARK: Public

    public let fromAxis: YAxis
    public let fromLayoutGuide: LayoutGuide<FromView>
    public let toAxis: YAxis
    public let toLayoutGuide: LayoutGuide<ToView>
    public let constant: CGFloat
    public let relation: NSLayoutConstraint.Relation
    public let priority: UILayoutPriority
    public let active: Bool

    public func constraint(from fromView: FromView, to toView: ToView) -> NSLayoutConstraint {
        fromView.anchor(axis: fromAxis, layoutGuide: fromLayoutGuide).pin(
            to: toView.anchor(axis: toAxis, layoutGuide: toLayoutGuide),
            relation,
            constant: constant,
            priority: priority,
            activate: active
        )
    }
}
