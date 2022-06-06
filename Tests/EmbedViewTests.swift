//
//  EmbedTests.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 1/14/20.
//  Copyright © 2020 Peter Meyers. All rights reserved.
//

import UIKitLayout
import XCTest

final class EmbedViewTests: XCTestCase {
    private let parent = UIView()
    private let child = UIView()

    func testEmbed() {
        AssertEqualConstraints(
            parent.embed(child).constraints.map { $1 },
            [
                child.topAnchor.constraint(equalTo: parent.topAnchor) <- { $0.isActive = true },
                child.bottomAnchor.constraint(equalTo: parent.bottomAnchor) <- { $0.isActive = true },
                child.leadingAnchor.constraint(equalTo: parent.leadingAnchor) <- { $0.isActive = true },
                child.trailingAnchor.constraint(equalTo: parent.trailingAnchor) <- { $0.isActive = true }
            ]
        )
    }

    func testEmbedWithInset() {
        AssertEqualConstraints(
            parent.embed(child, inset: 10).constraints.map { $1 },
            [
                child.topAnchor.constraint(equalTo: parent.topAnchor, constant: 10) <- { $0.isActive = true },
                child.bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -10) <- { $0.isActive = true },
                child.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 10) <- { $0.isActive = true },
                child.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -10) <- { $0.isActive = true }
            ]
        )
    }

    func testEmbedWithSpecificAnchors() {
        AssertEqualConstraints(
            parent.embed(child, pin: [
                .left(offset: 5),
                .bottom(offset: -5),
                .height(.greaterThanOrEqual, ratio: .half)
            ]).constraints.map { $1 },
            [
                child.leftAnchor.constraint(
                    equalTo: parent.leftAnchor,
                    constant: 5
                ) <- { $0.isActive = true },
                child.bottomAnchor.constraint(
                    equalTo: parent.bottomAnchor,
                    constant: -5
                ) <- { $0.isActive = true },
                child.heightAnchor.constraint(
                    greaterThanOrEqualTo: parent.heightAnchor,
                    multiplier: 0.5,
                    constant: 0
                ) <- { $0.isActive = true }
            ]
        )
    }
}
