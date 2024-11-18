//
//  UIViewController.swift
//  UIKitLayout
//
//  Created by James Ortiz on 5/18/21.
//  Copyright © 2021 Nextdoor, Inc. All rights reserved.
//  periphery:ignore:all

import UIKit

extension UIViewController {
    /**
     This struct is returned from all embed functions. It can be used to reference the embedded view as
     well as the constraints that were created.
     */
    public struct Embedded<Controller> where Controller: UIViewController {
        public let controller: Controller
        public let constraints: [(convertable: ConstraintConvertable<UIView, UIView>, constraint: NSLayoutConstraint)]
    }

    /**
     Adds a child view controller and embeds its view in the receiver's view with the given inset.
     */
    @discardableResult
    public func embed<Controller>(
        _ child: Controller,
        inset: CGFloat
    ) -> Embedded<Controller> {
        embed(child, pin: .allEdges(inset: inset))
    }

    /**
     Adds a child view controller and embeds its view in the receiver's view with the given constraints.
     */
    @discardableResult
    public func embed<Controller>(
        _ child: Controller,
        pin constraintConvertables: [ConstraintConvertable<UIView, UIView>] = .allEdges
    ) -> Embedded<Controller> {
        addChild(child)
        let embeddedView = view.embed(child.view, pin: constraintConvertables)
        child.didMove(toParent: self)
        return Embedded(controller: child, constraints: embeddedView.constraints)
    }
}
