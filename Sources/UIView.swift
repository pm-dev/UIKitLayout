import UIKit

@MainActor
public protocol UIViewEmbeddable {}
extension UIView: UIViewEmbeddable {}

extension UIView {
    public var left: XAxisAnchor {
        .left(leftAnchor)
    }

    public var leading: XAxisAnchor {
        .leading(leadingAnchor)
    }

    public var right: XAxisAnchor {
        .right(rightAnchor)
    }

    public var trailing: XAxisAnchor {
        .trailing(trailingAnchor)
    }

    public var centerX: XAxisAnchor {
        .centerX(centerXAnchor)
    }

    public var bottom: YAxisAnchor {
        .bottom(bottomAnchor)
    }

    public var top: YAxisAnchor {
        .top(topAnchor)
    }

    public var centerY: YAxisAnchor {
        .centerY(centerYAnchor)
    }

    public var width: DimensionAnchor {
        DimensionAnchor(anchor: widthAnchor)
    }

    public var height: DimensionAnchor {
        DimensionAnchor(anchor: heightAnchor)
    }
}

/**
 Use these functions to add a subview to a parent view and simultaneously
 pin the subview's anchors to anchors of the parent view.
 */
extension UIView {
    /**
     This struct is returned from all embed functions. It can be used to reference the embedded view as
     well as the constraints that were created.
     */
    public struct Embedded<Parent, Child> where Parent: UIView, Child: UIView {
        public let view: Child
        public let constraints: [(convertable: ConstraintConvertable<Child, Parent>, constraint: NSLayoutConstraint)]
    }
}

extension UIViewEmbeddable where Self: UIView {

    /**
     Adds a subview and pins all four edges to a layout guide of the receiver with a given inset.
     */
    @discardableResult
    public func embed<View>(
        _ child: View,
        inset: CGFloat,
        from layoutGuide: LayoutGuide<Self> = .view
    ) -> Embedded<Self, View> {
        embed(child, pin: .allEdges(inset: inset, from: layoutGuide))
    }

    /**
     Adds a subview and pins all four edges to a layout guide of the receiver with a given inset.
     */
    @discardableResult
    public func embed<View>(
        _ child: View,
        inset: UIEdgeInsets,
        from layoutGuide: LayoutGuide<Self> = .view
    ) -> Embedded<Self, View> {
        embed(child, pin: .allEdges(inset: inset, from: layoutGuide))
    }

    /**
     Adds a subview and pins a given set of anchors to a layout guide of the receiver.
     */
    @discardableResult
    public func embed<View>(
        _ child: View,
        pin constraintConvertables: [ConstraintConvertable<View, Self>] = .allEdges
    ) -> Embedded<Self, View> {
        child.translatesAutoresizingMaskIntoConstraints = false
        addSubview(child)
        return Embedded(
            view: child,
            constraints: constraintConvertables.map { c in
                (c, c.constraint(from: child, to: self))
            }
        )
    }
}

/**
 Use these functions to constrain dimensions of a view.
 */
extension UIView {
    /**
     Constrains the view to a constant aspect ratio of "width to height".
     */
    @discardableResult
    public func constrain(
        _ relation: NSLayoutConstraint.Relation = .equal,
        aspectRatio: Ratio,
        plus: CGFloat = 0,
        priority: UILayoutPriority = .required,
        activate: Bool = true
    ) -> NSLayoutConstraint {
        width.pin(to: height, relation, ratio: aspectRatio, plus: plus, priority: priority, activate: activate)
    }
}

extension UIView: Constrainable {
    public func anchor(axis: XAxis) -> NSLayoutXAxisAnchor {
        switch axis {
        case .centerX: centerXAnchor
        case .leading: leadingAnchor
        case .left: leftAnchor
        case .right: rightAnchor
        case .trailing: trailingAnchor
        }
    }

    public func anchor(axis: YAxis) -> NSLayoutYAxisAnchor {
        switch axis {
        case .bottom: bottomAnchor
        case .centerY: centerYAnchor
        case .top: topAnchor
        }
    }

    public func anchor(dimension: Dimension) -> NSLayoutDimension {
        switch dimension {
        case .width: widthAnchor
        case .height: heightAnchor
        }
    }
}

extension Constrainable where Self: UIView {
    func anchor(axis: XAxis, layoutGuide: LayoutGuide<Self>) -> NSLayoutXAxisAnchor {
        self[keyPath: layoutGuide.path].anchor(axis: axis)
    }

    func anchor(axis: YAxis, layoutGuide: LayoutGuide<Self>) -> NSLayoutYAxisAnchor {
        self[keyPath: layoutGuide.path].anchor(axis: axis)
    }

    func anchor(dimension: Dimension, layoutGuide: LayoutGuide<Self>) -> NSLayoutDimension {
        self[keyPath: layoutGuide.path].anchor(dimension: dimension)
    }
}
