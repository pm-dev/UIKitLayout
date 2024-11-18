import UIKit

@MainActor
protocol Constrainable {
    func anchor(axis: XAxis) -> NSLayoutXAxisAnchor
    func anchor(axis: YAxis) -> NSLayoutYAxisAnchor
    func anchor(dimension: Dimension) -> NSLayoutDimension
}
