//
//  Apply.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 11/28/19.
//  Copyright © 2019 Peter Meyers. All rights reserved.
//

import Foundation

infix operator <-: AssignmentPrecedence

func <- <T: AnyObject>(left: T, right: (T) -> Void) -> T {
    right(left)
    return left
}
