//
//  Equality.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 1/14/20.
//  Copyright © 2020 Peter Meyers. All rights reserved.
//

import XCTest

func AssertEqualConstraints(_ lhs: [NSLayoutConstraint], _ rhs: [NSLayoutConstraint]) {
    XCTAssertEqual(
        lhs.count,
        rhs.count,
        "Count of constraint array not equal"
    )
    zip(lhs, rhs).forEach {
        AssertEqualConstraints($0, $1)
    }
}

func AssertEqualConstraints(_ lhs: NSLayoutConstraint, _ rhs: NSLayoutConstraint) {
    XCTAssert(
        lhs.firstItem === rhs.firstItem,
        """
        `firstItem` \(String(describing: lhs.firstItem)) is not the same
        instance as \(String(describing: rhs.firstItem))
        """
    )
    XCTAssertEqual(
        lhs.firstAttribute,
        rhs.firstAttribute,
        "`firstAttribute` \(lhs.firstAttribute) is not equal to \(rhs.firstAttribute)"
    )
    XCTAssertEqual(
        lhs.relation,
        rhs.relation,
        "`relation` \(lhs.relation) is not equal to \(rhs.relation)"
    )
    XCTAssert(
        lhs.secondItem === rhs.secondItem,
        """
        `secondItem` \(String(describing: lhs.secondItem)) is not the same instance
        as \(String(describing: rhs.secondItem))
        """
    )
    XCTAssertEqual(
        lhs.secondAttribute,
        rhs.secondAttribute,
        "`secondAttribute` \(lhs.secondAttribute) is not equal to \(rhs.secondAttribute)"
    )
    XCTAssertEqual(
        lhs.multiplier,
        rhs.multiplier,
        "`multiplier` \(lhs.multiplier) is not equal to \(rhs.multiplier)"
    )
    XCTAssertEqual(
        lhs.constant,
        rhs.constant,
        "`constant` \(lhs.constant) is not equal to \(rhs.constant)"
    )
    XCTAssertEqual(
        lhs.priority,
        rhs.priority,
        "`priority` \(lhs.priority) is not equal to \(rhs.priority)"
    )
    XCTAssertEqual(
        lhs.isActive,
        rhs.isActive,
        "`isActive` \(lhs.isActive) is not equal to \(rhs.isActive)"
    )
    XCTAssertEqual(
        lhs.identifier,
        rhs.identifier,
        "`identifier` \(String(describing: lhs.identifier)) is not equal to \(String(describing: rhs.identifier))"
    )
}
