import UIKit

/// This protocol is only implemented by `ConstraintConvertable` and is primarily intended for generic constraints.
public protocol ConstraintConvertableProtocol<FromView, ToView> {
    associatedtype FromView: UIView
    associatedtype ToView: UIView
}

/// A Constraint Convertable represents how to create a constraint given a parent and child view. Used by the `embed`
/// function
@MainActor
public enum ConstraintConvertable<FromView: UIView, ToView: UIView>: ConstraintConvertableProtocol {
    case xAxis(XAxisRelation<FromView, ToView>)
    case yAxis(YAxisRelation<FromView, ToView>)
    case dimension(DimensionRelation<FromView, ToView>)

    // MARK: Internal

    func constraint(from fromView: FromView, to toView: ToView) -> NSLayoutConstraint {
        switch self {
        case let .xAxis(relation): relation.constraint(from: fromView, to: toView)
        case let .yAxis(relation): relation.constraint(from: fromView, to: toView)
        case let .dimension(relation): relation.constraint(from: fromView, to: toView)
        }
    }
}

extension ConstraintConvertable {
    public static var left: ConstraintConvertable { .left(inset: 0) }
    public static var right: ConstraintConvertable { .right(inset: 0) }
    public static var leading: ConstraintConvertable { .leading(inset: 0) }
    public static var trailing: ConstraintConvertable { .trailing(inset: 0) }
    public static var centerX: ConstraintConvertable { .centerX() }
    public static var top: ConstraintConvertable { .top(inset: 0) }
    public static var bottom: ConstraintConvertable { .bottom(inset: 0) }
    public static var centerY: ConstraintConvertable { .centerY() }
    public static var width: ConstraintConvertable { .width() }
    public static var height: ConstraintConvertable { .height() }

    /// Adds a constraint which pins two left edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's left edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     Inset from the left means the child's left edge will be to the right the parent's anchor edge. Negative
    /// values
    ///     will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's left edge to its parent
    public static func left(
        of layoutGuide: LayoutGuide<FromView> = .view,
        to toAxis: XAxis = .left,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        left(
            of: layoutGuide,
            .equal,
            to: toAxis,
            toLayoutGuide: toLayoutGuide,
            inset: inset,
            priority: priority,
            active: active
        )
    }

    /// Adds a constraint which pins two left edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's left edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     Inset from the left means the child's left edge will be to the right the parent's anchor edge. Negative
    /// values
    ///     will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's left edge to its parent
    public static func left(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .left,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(inset >= 0, "inset must be positive")
        return .xAxis(XAxisRelation(
            .left,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation,
            constant: inset,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two left edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - overflow: The spacing in points to extend the embedded view's left edge beyond (i.e. to the left of) the
    ///     embedding (i.e. parent) view's edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's left edge to its parent
    public static func left(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .left,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        overflow: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(overflow >= 0, "overflow must be positive")
        return .xAxis(XAxisRelation(
            .left,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation.inverse,
            constant: -overflow,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two leading edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's leading edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     In left-to-right languages this means the child's edge will be to the right of the parent's edge.  Negative
    ///     values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's leading edge to its parent
    public static func leading(
        of layoutGuide: LayoutGuide<FromView> = .view,
        to toAxis: XAxis = .leading,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        leading(
            of: layoutGuide,
            .equal,
            to: toAxis,
            toLayoutGuide: toLayoutGuide,
            inset: inset,
            priority: priority,
            active: active
        )
    }

    /// Adds a constraint which pins two leading edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's leading edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     In left-to-right languages this means the child's edge will be to the right of the parent's edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's leading edge to its parent
    public static func leading(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .leading,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(inset >= 0, "inset must be positive")
        return .xAxis(XAxisRelation(
            .leading,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation,
            constant: inset,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two leading edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - overflow: The spacing in points to extend the embedded view's leading edge beyond the
    ///     embedding (i.e. parent) view's edge.
    ///     In left-to-right languages this means the child's edge will be to the left of the parent's edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's leading edge to its parent
    public static func leading(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .leading,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        overflow: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(overflow >= 0, "overflow must be positive")
        return .xAxis(XAxisRelation(
            .leading,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation.inverse,
            constant: -overflow,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two right edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's right edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     Inset from the right means the child's right edge will be to the left the parent's anchor edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's right edge to its parent
    public static func right(
        of layoutGuide: LayoutGuide<FromView> = .view,
        to toAxis: XAxis = .right,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        right(
            of: layoutGuide,
            .equal,
            to: toAxis,
            toLayoutGuide: toLayoutGuide,
            inset: inset,
            priority: priority,
            active: active
        )
    }

    /// Adds a constraint which pins two right edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's right edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     Inset from the right means the child's right edge will be to the left the parent's anchor edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's right edge to its parent
    public static func right(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .right,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(inset >= 0, "inset must be positive")
        return .xAxis(XAxisRelation(
            .right,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation.inverse,
            constant: -inset,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two right edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - overflow: The spacing in points to extend the embedded view's right edge beyond (i.e. to the right of) the
    ///     embedding (i.e. parent) view's edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's right edge to its parent
    public static func right(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .right,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        overflow: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(overflow >= 0, "overflow must be positive")
        return .xAxis(XAxisRelation(
            .right,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation,
            constant: overflow,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two trailing edges. The edges are typically two views: a view and a subview,
    /// however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's trailing edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     In left-to-right languages this means the child's edge will be to the left of the parent's edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's trailing edge to its parent
    public static func trailing(
        of layoutGuide: LayoutGuide<FromView> = .view,
        to toAxis: XAxis = .trailing,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        trailing(
            of: layoutGuide,
            .equal,
            to: toAxis,
            toLayoutGuide: toLayoutGuide,
            inset: inset,
            priority: priority,
            active: active
        )
    }

    /// Adds a constraint which pins two trailing edges. The edges are typically two views: a view and a subview,
    /// however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's trailing edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     In left-to-right languages this means the child's edge will be to the left of the parent's edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's trailing edge to its parent
    public static func trailing(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .trailing,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(inset >= 0, "inset must be positive")
        return .xAxis(XAxisRelation(
            .trailing,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation.inverse,
            constant: -inset,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two trailing edges. The edges are typically two views: a view and a subview,
    /// however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - overflow: The spacing in points to extend the embedded view's trailing edge beyond the
    ///     embedding (i.e. parent) view's edge.
    ///     In left-to-right languages this means the child's edge will be to the right of the parent's edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's trailing edge to its parent
    public static func trailing(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .trailing,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        overflow: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(overflow >= 0, "overflow must be positive")
        return .xAxis(XAxisRelation(
            .trailing,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation,
            constant: overflow,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two center-x anchor points. The anchor points are typically in reference to two
    /// views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - offset: The spacing in points to offset the embedded view's centerX anchor point from the
    ///     embedding (i.e. parent) view's anchor point.
    ///     A positive offset means the child's center anchor will be to the right of the parent's anchor point,
    ///     while a negative offset will put the child's anchor to the left of the parent's.
    ///   - priority: The constraint's priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's center x anchor point to its parent.
    public static func centerX(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: XAxis = .centerX,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        offset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        .xAxis(XAxisRelation(
            .centerX,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation,
            constant: offset,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two top edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's top edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     Inset from the top means the child's top edge will be below the parent's anchor edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's top edge to its parent
    public static func top(
        of layoutGuide: LayoutGuide<FromView> = .view,
        to toAxis: YAxis = .top,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        top(
            of: layoutGuide,
            .equal,
            to: toAxis,
            toLayoutGuide: toLayoutGuide,
            inset: inset,
            priority: priority,
            active: active
        )
    }

    /// Adds a constraint which pins two top edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's top edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     Inset from the top means the child's top edge will be below the parent's anchor edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's top edge to its parent
    public static func top(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: YAxis = .top,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(inset >= 0, "inset must be positive")
        return .yAxis(YAxisRelation(
            .top,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation,
            constant: inset,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two top edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - overflow: The spacing in points to extend the embedded view's top edge beyond (i.e. above) the
    ///     embedding (i.e. parent) view's edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's top edge to its parent
    public static func top(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: YAxis = .top,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        overflow: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(overflow >= 0, "overflow must be positive")
        return .yAxis(YAxisRelation(
            .top,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation.inverse,
            constant: -overflow,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two bottom edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's bottom edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     Inset from the bottom means the child's bottom edge will be above the parent's anchor edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's bottom edge to its parent
    public static func bottom(
        of layoutGuide: LayoutGuide<FromView> = .view,
        to toAxis: YAxis = .bottom,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        bottom(
            of: layoutGuide,
            .equal,
            to: toAxis,
            toLayoutGuide: toLayoutGuide,
            inset: inset,
            priority: priority,
            active: active
        )
    }

    /// Adds a constraint which pins two bottom edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - inset: The spacing in points to inset the embedded view's bottom edge from the
    ///     embedding (i.e. parent) view's edge.
    ///     Inset from the bottom means the child's bottom edge will be above the parent's anchor edge.
    ///     Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's bottom edge to its parent
    public static func bottom(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: YAxis = .bottom,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        inset: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(inset >= 0, "inset must be positive")
        return .yAxis(YAxisRelation(
            .bottom,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation.inverse,
            constant: -inset,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two bottom edges. The edges are typically two views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - overflow: The spacing in points to extend the embedded view's bottom edge beyond (i.e. below) the embedding
    /// (i.e. parent) view's edge.
    ///    Negative values will throw an assertion error.
    ///   - priority: The constraints priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's bottom edge to its parent
    public static func bottom(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: YAxis = .bottom,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        overflow: CGFloat,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        assert(overflow >= 0, "overflow must be positive")
        return .yAxis(YAxisRelation(
            .bottom,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation,
            constant: overflow,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins two center-y anchor points. The anchor points are typically in reference to two
    /// views: a view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toAxis: The anchor position of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - offset: The spacing in points to offset the embedded view's center-y anchor point from the
    ///     embedding (i.e. parent) view's anchor point.
    ///     A positive offset means the child's center anchor will be below the parent's anchor point.
    ///     A negative offset will put the childs anchor above that of the parent.
    ///   - priority: The constraint's priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's center-y anchor point to its parent.
    public static func centerY(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toAxis: YAxis = .centerY,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        offset: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        .yAxis(YAxisRelation(
            .centerY,
            layoutGuide,
            to: toAxis,
            toLayoutGuide,
            relation,
            constant: offset,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins the width of two views. The widths are typically in reference to two views: a view
    /// and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toDimension: The dimension of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - ratio: A multiplier based on the parent's dimension and applied to the child's width.
    ///   - plus: The spacing in points to add (positive) or subtract (negative) from the
    ///     embedding (i.e. parent) view's width.
    ///   - priority: The constraint's priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's width to its parent.
    public static func width(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toDimension: Dimension = .width,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        ratio: Ratio = .equal,
        plus: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        .dimension(DimensionRelation(
            .width,
            layoutGuide,
            to: toDimension,
            toLayoutGuide,
            relation,
            multiplier: ratio,
            constant: plus,
            priority: priority,
            active: active
        ))
    }

    /// Adds a constraint which pins the height of two views. The heights are typically in reference to two views: a
    /// view and a subview, however
    /// it's also possible to use layout guides of those views.
    /// - Parameters:
    ///   - layoutGuide: The layout guide tied to the view that's being embedded.
    ///   - relation: Whether the constraint between the two views should be equal, lessThan or greaterThan.
    ///   - toDimension: The dimension of the embedding (i.e. parent) view that is being pinned to.
    ///   - toLayoutGuide: The layout guide tied to the view that is embedding the subview.
    ///   - ratio: A multiplier based on the parent's dimension and applied to the child's height.
    ///   - plus: The spacing in points to add (positive) or subtract (negative) from the
    ///     embedding (i.e. parent) view's height.
    ///   - priority: The constraint's priority
    ///   - active: Whether the constraint should be made active automatically after the child view is embedded.
    /// - Returns: A ConstraintConvertable, which pins a child's height to its parent.
    public static func height(
        of layoutGuide: LayoutGuide<FromView> = .view,
        _ relation: NSLayoutConstraint.Relation = .equal,
        to toDimension: Dimension = .height,
        toLayoutGuide: LayoutGuide<ToView> = .view,
        ratio: Ratio = .equal,
        plus: CGFloat = 0,
        priority: UILayoutPriority = .required,
        active: Bool = true
    ) -> Self {
        .dimension(DimensionRelation(
            .height,
            layoutGuide,
            to: toDimension,
            toLayoutGuide,
            relation,
            multiplier: ratio,
            constant: plus,
            priority: priority,
            active: active
        ))
    }
}

extension Array where Element: ConstraintConvertableProtocol {
    @MainActor
    public static var allEdges: [ConstraintConvertable<Element.FromView, Element.ToView>] { .allEdges(inset: 0) }

    @MainActor
    public static func allEdges(
        inset: CGFloat,
        from layoutGuide: LayoutGuide<Element.ToView> = .view
    ) -> [ConstraintConvertable<
        Element.FromView,
        Element.ToView
    >] {
        allEdges(inset: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset), from: layoutGuide)
    }

    @MainActor
    public static func allEdges(
        inset: UIEdgeInsets,
        from layoutGuide: LayoutGuide<Element.ToView> = .view
    ) -> [ConstraintConvertable<
        Element.FromView,
        Element.ToView
    >] {
        [
            .top(toLayoutGuide: layoutGuide, inset: inset.top),
            .bottom(toLayoutGuide: layoutGuide, inset: inset.bottom),
            .leading(toLayoutGuide: layoutGuide, inset: inset.left),
            .trailing(toLayoutGuide: layoutGuide, inset: inset.right)
        ]
    }
}
