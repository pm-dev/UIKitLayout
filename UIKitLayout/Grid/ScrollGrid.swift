//
//  ScrollGrid.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 1/20/20.
//  Copyright © 2020 Peter Meyers. All rights 

import UIKit

/**
 A grid which can be scrolled to view any cells that have overrun the
 right and/or bottom sides of the view. When the scroll view scrolls, the
 top row and left column will be frozen in place (i.e. hover over the other cells)
 */
open class ScrollGrid: UIView {
    private let grid = Grid()
    private let scrollView = UIScrollView()
    private var rowSpacing: CGFloat = 0
    private var columnSpacing: CGFloat = 0

    override public init(frame: CGRect) {
        super.init(frame: frame)
        didInstantiate()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        didInstantiate()
    }

    private func didInstantiate() {
        scrollView.bounces = false
        scrollView.delegate = self
        scrollView.embed(grid, pin: [.top, .left, .right, .bottom])
        embed(scrollView)
    }

    public func make(
        rowCount: Int,
        columnCount: Int,
        rowSpacing: CGFloat = 0,
        columnSpacing: CGFloat = 0,
        equalCells: Bool = false,
        cells: (_ rowIndex: Int, _ columnIndex: Int) -> UIView
    ) {
        self.rowSpacing = rowSpacing
        self.columnSpacing = columnSpacing
        grid.make(
            rowCount: rowCount,
            columnCount: columnCount,
            rowSpacing: rowSpacing,
            columnSpacing: columnSpacing,
            equalCells: equalCells,
            cells: cells
        )
        if rowCount > 0, columnCount > 0 {
            let firstCell = grid.rows[0][0]

            let firstRowSeparator = UIView()
            firstRowSeparator.backgroundColor = backgroundColor
            scrollView.embed(firstRowSeparator, pin: [.left, .right])
            firstRowSeparator.top.pin(to: firstCell.bottom)
            firstRowSeparator.height.pin(to: rowSpacing)

            let firstColumnSeparator = UIView()
            firstColumnSeparator.backgroundColor = backgroundColor
            scrollView.embed(firstColumnSeparator, pin: [.top, .bottom])
            firstColumnSeparator.width.pin(to: columnSpacing)
            firstColumnSeparator.left.pin(to: firstCell.right)
        }
    }
}

extension ScrollGrid: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        grid.firstRowTopConstraints.forEach { constraint in
            constraint.constant = -offset.y
        }
        grid.firstRowBottomConstraints.forEach { constraint in
            constraint.constant = offset.y - rowSpacing
        }
        grid.firstColumnLeftConstraints.forEach { constraint in
            constraint.constant = -offset.x
        }
        grid.firstColumnRightConstraints.forEach { constraint in
            constraint.constant = offset.x - columnSpacing
        }
    }
}
