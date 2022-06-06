//
//  PinTests.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 1/14/20.
//  Copyright © 2020 Peter Meyers. All rights reserved.
//

import UIKitLayout
import XCTest

class PinTests: XCTestCase {
    private let parent = UIView()
    private let first = UIView()
    private let second = UIView()

    override func setUp() {
        super.setUp()
        // Constraints between two items must be in the same view heirarchy
        parent.addSubview(first)
        parent.addSubview(second)
    }

    func testVerticalPin() {
        AssertEqualConstraints(
            first.bottom.pin(to: second.top, spacing: 5),
            NSLayoutConstraint(
                item: first,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second,
                attribute: .top,
                multiplier: 1,
                constant: -5
            ) <- { $0.isActive = true }
        )

        AssertEqualConstraints(
            first.top.pin(to: second.bottom, spacing: 5),
            NSLayoutConstraint(
                item: first,
                attribute: .top,
                relatedBy: .equal,
                toItem: second,
                attribute: .bottom,
                multiplier: 1,
                constant: 5
            ) <- { $0.isActive = true }
        )
    }

    func testHorizontalPin() {
        AssertEqualConstraints(
            first.trailing.pin(to: second.leading, spacing: 2),
            NSLayoutConstraint(
                item: first,
                attribute: .trailing,
                relatedBy: .equal,
                toItem: second,
                attribute: .leading,
                multiplier: 1,
                constant: -2
            ) <- { $0.isActive = true }
        )

        AssertEqualConstraints(
            first.leading.pin(to: second.trailing, spacing: 2),
            NSLayoutConstraint(
                item: first,
                attribute: .leading,
                relatedBy: .equal,
                toItem: second,
                attribute: .trailing,
                multiplier: 1,
                constant: 2
            ) <- { $0.isActive = true }
        )
    }

    func testPinGte() {
        AssertEqualConstraints(
            first.trailing.pin(to: second.leading, .greaterThanOrEqual, spacing: 2),
            NSLayoutConstraint(
                item: first,
                attribute: .trailing,
                relatedBy: .lessThanOrEqual,
                toItem: second,
                attribute: .leading,
                multiplier: 1,
                constant: -2
            ) <- { $0.isActive = true }
        )

        AssertEqualConstraints(
            first.leading.pin(to: second.trailing, .greaterThanOrEqual, spacing: 2),
            NSLayoutConstraint(
                item: first,
                attribute: .leading,
                relatedBy: .greaterThanOrEqual,
                toItem: second,
                attribute: .trailing,
                multiplier: 1,
                constant: 2
            ) <- { $0.isActive = true }
        )
    }

    func testPinLte() {
        AssertEqualConstraints(
            first.trailing.pin(to: second.leading, .lessThanOrEqual, spacing: 2),
            NSLayoutConstraint(
                item: first,
                attribute: .trailing,
                relatedBy: .greaterThanOrEqual,
                toItem: second,
                attribute: .leading,
                multiplier: 1,
                constant: -2
            ) <- { $0.isActive = true }
        )

        AssertEqualConstraints(
            first.leading.pin(to: second.trailing, .lessThanOrEqual, spacing: 2),
            NSLayoutConstraint(
                item: first,
                attribute: .leading,
                relatedBy: .lessThanOrEqual,
                toItem: second,
                attribute: .trailing,
                multiplier: 1,
                constant: 2
            ) <- { $0.isActive = true }
        )
    }

    func testPinMargins() {
        AssertEqualConstraints(
            first.layoutMarginsGuide.bottom.pin(to: second.layoutMarginsGuide.top),
            NSLayoutConstraint(
                item: first.layoutMarginsGuide,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second.layoutMarginsGuide,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = true }
        )
    }

    func testPinSafeArea() {
        AssertEqualConstraints(
            first.safeAreaLayoutGuide.bottom.pin(to: second.top),
            NSLayoutConstraint(
                item: first.safeAreaLayoutGuide,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = true }
        )
    }

    func testPinReadableContent() {
        AssertEqualConstraints(
            first.bottom.pin(to: second.readableContentGuide.top),
            NSLayoutConstraint(
                item: first,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second.readableContentGuide,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = true }
        )
    }

    func testPinUnrequired() {
        AssertEqualConstraints(
            first.bottom.pin(to: second.top, priority: .defaultHigh),
            NSLayoutConstraint(
                item: first,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = true; $0.priority = .defaultHigh }
        )
    }

    func testPinUnactivated() {
        AssertEqualConstraints(
            first.bottom.pin(to: second.top, activate: false),
            NSLayoutConstraint(
                item: first,
                attribute: .bottom,
                relatedBy: .equal,
                toItem: second,
                attribute: .top,
                multiplier: 1,
                constant: 0
            ) <- { $0.isActive = false }
        )
    }
}
