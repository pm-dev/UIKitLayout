//
//  ConstrainTests.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 1/14/20.
//  Copyright © 2020 Peter Meyers. All rights reserved.
//

import UIKitLayout
import XCTest

class ConstrainTests: XCTestCase {
    private let view = UIView()

    func testPinWidthEq() {
        AssertEqualConstraints(
            view.width.pin(to: 5),
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = true }
        )
    }

    func testPinWidthLte() {
        AssertEqualConstraints(
            view.width.pin(.lessThanOrEqual, to: 5),
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .lessThanOrEqual,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = true }
        )
    }

    func testPinWidthGte() {
        AssertEqualConstraints(
            view.width.pin(.greaterThanOrEqual, to: 5),
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .greaterThanOrEqual,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = true }
        )
    }

    func testPinHeightEq() {
        AssertEqualConstraints(
            view.height.pin(to: 5),
            NSLayoutConstraint(
                item: view,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = true }
        )
    }

    func testPinHeightGte() {
        AssertEqualConstraints(
            view.height.pin(.greaterThanOrEqual, to: 5),
            NSLayoutConstraint(
                item: view,
                attribute: .height,
                relatedBy: .greaterThanOrEqual,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = true }
        )
    }

    func testPinHeightLte() {
        AssertEqualConstraints(
            view.height.pin(.lessThanOrEqual, to: 5),
            NSLayoutConstraint(
                item: view,
                attribute: .height,
                relatedBy: .lessThanOrEqual,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = true }
        )
    }

    func testConstrainUnactivated() {
        AssertEqualConstraints(
            view.height.pin(to: 5, activate: false),
            NSLayoutConstraint(
                item: view,
                attribute: .height,
                relatedBy: .equal,
                toItem: nil,
                attribute: .notAnAttribute,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = false }
        )
    }

    func testConstrainAspectRatio() {
        AssertEqualConstraints(
            view.constrain(aspectRatio: .half),
            NSLayoutConstraint(
                item: view,
                attribute: .width,
                relatedBy: .equal,
                toItem: view,
                attribute: .height,
                multiplier: 0.5,
                constant: 0
            ) <- { $0.isActive = true }
        )
    }
}
