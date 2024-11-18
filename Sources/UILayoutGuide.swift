//
//  UILayoutGuide.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 1/24/20.
//  Copyright © 2020 Peter Meyers. All rights reserved.
//  periphery:ignore:all

import UIKit

extension UILayoutGuide {
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

extension UILayoutGuide: Constrainable {
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
