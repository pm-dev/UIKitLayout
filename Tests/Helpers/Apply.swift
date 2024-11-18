import Foundation

infix operator <-: AssignmentPrecedence

func <- <T: AnyObject>(left: T, right: (T) -> Void) -> T {
    right(left)
    return left
}
