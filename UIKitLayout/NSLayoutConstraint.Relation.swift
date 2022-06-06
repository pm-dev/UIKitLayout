//
//  NSLayoutConstraint.Relation.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 1/24/20.
//  Copyright © 2020 Peter Meyers. All rights reserved.
//

import UIKit

extension NSLayoutConstraint.Relation {
    var inverse: NSLayoutConstraint.Relation {
        switch self {
        case .equal: return .equal
        case .greaterThanOrEqual: return .lessThanOrEqual
        case .lessThanOrEqual: return .greaterThanOrEqual
        @unknown default: fatalError("NSLayoutConstraint.Relation type <\(self)> unsupported")
        }
    }
}
