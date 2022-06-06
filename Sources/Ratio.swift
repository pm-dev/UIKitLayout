//
//  Ratio.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 11/7/19.
//  Copyright © 2019 Peter Meyers. All rights reserved.

import UIKit

/**
 A relation between two integers
 */
public typealias Ratio = CGFloat

extension Ratio {
    public static let equal = Ratio(1, to: 1)
    public static let half = Ratio(1, to: 2)

    public var inverse: Ratio {
        1 / self
    }

    public init(_ first: Int, to second: Int) {
        self = CGFloat(first) / CGFloat(second)
    }

    public init(_ width: CGFloat, to height: CGFloat) {
        self = width / height
    }

    public init(_ size: CGSize) {
        self = size.width / size.height
    }
}
