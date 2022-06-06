//
//  EmbedViewControllerTests.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 6/9/21.
//  Copyright © 2020 Peter Meyers. All rights reserved.
//

import UIKitLayout
import XCTest

final class EmbedViewControllerTests: XCTestCase {
    private let parent = UIViewController()
    private let child = UIViewController()

    func testEmbed() {
        AssertEqualConstraints(
            parent.embed(child).constraints.map { $1 },
            [
                child.view.topAnchor.constraint(equalTo: parent.view.topAnchor) <- { $0.isActive = true },
                child.view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor) <- { $0.isActive = true },
                child.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor) <- { $0.isActive = true },
                child.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor) <- { $0.isActive = true }
            ]
        )
    }

    func testEmbedWithInset() {
        AssertEqualConstraints(
            parent.embed(child, inset: 10).constraints.map { $1 },
            [
                child.view.topAnchor.constraint(equalTo: parent.view.topAnchor, constant: 10) <- {
                    $0.isActive = true
                },
                child.view.bottomAnchor.constraint(equalTo: parent.view.bottomAnchor, constant: -10) <- {
                    $0.isActive = true
                },
                child.view.leadingAnchor.constraint(equalTo: parent.view.leadingAnchor, constant: 10) <- {
                    $0.isActive = true
                },
                child.view.trailingAnchor.constraint(equalTo: parent.view.trailingAnchor, constant: -10) <- {
                    $0.isActive = true
                }
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
                child.view.leftAnchor.constraint(
                    equalTo: parent.view.leftAnchor,
                    constant: 5
                ) <- { $0.isActive = true },
                child.view.bottomAnchor.constraint(
                    equalTo: parent.view.bottomAnchor,
                    constant: -5
                ) <- { $0.isActive = true },
                child.view.heightAnchor.constraint(
                    greaterThanOrEqualTo: parent.view.heightAnchor,
                    multiplier: 0.5,
                    constant: 0
                ) <- { $0.isActive = true }
            ]
        )
    }
}
