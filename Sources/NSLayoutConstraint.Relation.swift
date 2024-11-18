import UIKit

extension NSLayoutConstraint.Relation {
    var inverse: NSLayoutConstraint.Relation {
        switch self {
        case .equal: .equal
        case .greaterThanOrEqual: .lessThanOrEqual
        case .lessThanOrEqual: .greaterThanOrEqual
        @unknown default: fatalError("NSLayoutConstraint.Relation type <\(self)> unsupported")
        }
    }
}
