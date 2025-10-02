import UIKit

@available(iOS 17, *)
extension UIView {
    /// Registers a `handler` to execute every time the size class changes. `handler` is immediately called with the
    /// initial size class of the view.
    /// - Parameters:
    ///   - axis: The axis to observe (default: horizontal)
    ///   - handler: The callback to execute
    public func addSizeClassProxy(
        forAxis axis: LayoutAxis = .horizontal,
        handler: @escaping (UIUserInterfaceSizeClass) -> Void
    ) {
        let sizeClassKeyPath: KeyPath<UITraitCollection, UIUserInterfaceSizeClass> =
            switch axis {
            case .horizontal: \.horizontalSizeClass
            case .vertical: \.verticalSizeClass
            }
        let trait: UITrait =
            switch axis {
            case .horizontal: UITraitHorizontalSizeClass.self
            case .vertical: UITraitVerticalSizeClass.self
            }
        registerForTraitChanges([trait]) { (self: Self, _) in
            handler(self.traitCollection[keyPath: sizeClassKeyPath])
        }
        handler(traitCollection[keyPath: sizeClassKeyPath])
    }

    /// Activates layout constraints when the provided size class is active & deactivates them otherwise.
    /// - Parameters:
    ///   - sizeClass: The size class needed to activate the constraints
    ///   - axis: The axis to observe (default: horizontal)
    ///   - constraints: The constraints to activate or deactivate on size class changes
    public func activateForSizeClass(
        _ sizeClass: UIUserInterfaceSizeClass,
        axis: LayoutAxis = .horizontal,
        constraints: [NSLayoutConstraint]
    ) {
        addSizeClassProxy(forAxis: axis) { newSizeClass in
            if newSizeClass == sizeClass {
                NSLayoutConstraint.activate(constraints)
            } else {
                NSLayoutConstraint.deactivate(constraints)
            }
        }
    }

    /// Configures a set of constraints on size class updates. When the size class changes, the prior
    /// constraints are deactivated.
    /// - Parameters:
    ///   - axis: The axis to observe (default: horizontal)
    ///   - makeConstraints: Provides a list of constraints to activate based on the size class
    public func pinForSizeClass(
        axis: LayoutAxis = .horizontal,
        makeConstraints: @escaping (UIUserInterfaceSizeClass) -> [NSLayoutConstraint]
    ) {
        var constraintMap: [UIUserInterfaceSizeClass: [NSLayoutConstraint]] = [:]
        addSizeClassProxy(forAxis: axis) { sizeClass in
            var constraintsToDeactivateMap = constraintMap
            constraintsToDeactivateMap.removeValue(forKey: sizeClass)
            let constraintsToDeactivate = constraintsToDeactivateMap.values.flatMap(\.self)
            NSLayoutConstraint.deactivate(constraintsToDeactivate)

            if let existingConstraints = constraintMap[sizeClass] {
                NSLayoutConstraint.activate(existingConstraints)
            } else {
                let newConstraints = makeConstraints(sizeClass)
                constraintMap[sizeClass] = newConstraints
                NSLayoutConstraint.activate(newConstraints)
            }
        }
    }

    /// Configures a set of constraints on size class updates. When the size class changes, the prior
    /// constraints are deactivated.
    /// Example:
    /// ```
    /// myView.embed(subview, pin: [.top, .bottom])
    /// myView.pinForSizeClass(on: subview) { sizeClass in
    ///     let margin = self.margin(for: sizeClass)
    ///     return [
    ///         .leading(inset: margin),
    ///         .trailing(inset: margin)
    ///     ]
    /// }
    /// ```
    ///
    /// - Parameters:
    ///   - axis: The axis to observe (default: horizontal)
    ///   - subview: The subview in relation to provided constraints
    ///   - makeConstraints: Provides a list of constraints to activate based on the size clas
    public func pinForSizeClass(
        axis: LayoutAxis = .horizontal,
        on subview: UIView,
        makeConstraints: @escaping (UIUserInterfaceSizeClass) -> [ConstraintConvertable<UIView, UIView>]
    ) {
        pinForSizeClass(axis: axis) { [weak self] sizeClass in
            guard let self else { return [] }
            let constraints = makeConstraints(sizeClass)
            return constraints.map {
                $0.constraint(from: subview, to: self)
            }
        }
    }
}
