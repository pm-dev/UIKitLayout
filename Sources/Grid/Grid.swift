//
//  Grid.swift
//  UIKitLayout
//
//  Created by Peter Meyers on 12/30/19.
//  Copyright © 2019 Peter Meyers. All rights reserved.
//  periphery:ignore:all

import UIKit

/**
 A Grid is a n x m collection of views. All cells in a row will have the same height, based
 on the intrinsic content height of the tallest cell in the row. All cells in a column will have
 the same width, based on the intrinsic content width of the widest cell in the column.
 */
open class Grid: UIView {

    // MARK: Public

    public private(set) var rows: [[UIView]] = []

    /**
     Removes all cells from the grid.
     */
    public func clearCells() {
        for row in rows {
            for cell in row {
                cell.removeFromSuperview()
            }
        }
        rows.removeAll(keepingCapacity: true)
        firstRowTopConstraints.removeAll()
        firstRowBottomConstraints.removeAll()
        firstColumnLeftConstraints.removeAll()
        firstColumnRightConstraints.removeAll()
    }

    /**
     Removes all current cells from the grid, then rebuilds the grid with a closure that returns
     each cell in the grid.

     - parameter rowCount: The number of rows to have in this grid.
     - parameter columnCount: The number of columns to have in this grid.
     - parameter rowSpacing: The vertical distance between rows.
     - parameter columnSpacing: The horizontal distance between columns.
     - parameter equalCells: Whether each cell should be constrained to the same size.
     - parameter cells: A closure that returns the cell for a given row and column index in the grid.
     */
    public func make(
        rowCount: Int,
        columnCount: Int,
        rowSpacing: CGFloat = 0,
        columnSpacing: CGFloat = 0,
        equalCells: Bool = false,
        cells: (_ rowIndex: Int, _ columnIndex: Int) -> UIView
    ) {
        clearCells()
        for rowIndex in 0 ..< rowCount {
            var row: [UIView] = []
            for columnIndex in 0 ..< columnCount {
                row.append(cells(rowIndex, columnIndex))
            }
            rows.append(row)
        }
        for row in rows.reversed() {
            for cell in row.reversed() {
                cell.translatesAutoresizingMaskIntoConstraints = false
                addSubview(cell)
            }
        }
        if rowCount > 0 {
            for columnIndex in 0 ..< columnCount {
                let topCell = rows[0][columnIndex]
                firstRowTopConstraints.append(top.pin(to: topCell.top))
                let bottomCell = rows[rowCount - 1][columnIndex]
                bottom.pin(to: bottomCell.bottom, .greaterThanOrEqual)
            }
        }
        if columnCount > 0 {
            for rowIndex in 0 ..< rowCount {
                let leftCell = rows[rowIndex][0]
                firstColumnLeftConstraints.append(left.pin(to: leftCell.left))
                let rightCell = rows[rowIndex][columnCount - 1]
                right.pin(to: rightCell.right, .greaterThanOrEqual)
            }
        }
        for rowIndex in 0 ..< rowCount {
            for columnIndex in 0 ..< columnCount {
                let cell = rows[rowIndex][columnIndex]
                if equalCells, !(rowIndex == 0 && columnIndex == 0) {
                    let firstCell = rows[0][0]
                    firstCell.width.pin(to: cell.width)
                    firstCell.height.pin(to: cell.height)
                }
                let nextColumnIndex = columnIndex + 1
                if nextColumnIndex < columnCount {
                    let cellInNextColumn = rows[rowIndex][nextColumnIndex]
                    let constraint = cell.right.pin(to: cellInNextColumn.left, spacing: columnSpacing)
                    if columnIndex == 0 {
                        firstColumnRightConstraints.append(constraint)
                    }
                    cell.height.pin(to: cellInNextColumn.height)
                }
                let nextRowIndex = rowIndex + 1
                if nextRowIndex < rowCount {
                    let cellInNextRow = rows[nextRowIndex][columnIndex]
                    let constraint = cell.bottom.pin(to: cellInNextRow.top, spacing: rowSpacing)
                    if rowIndex == 0 {
                        firstRowBottomConstraints.append(constraint)
                    }
                    cell.width.pin(to: cellInNextRow.width)
                }
            }
        }
    }

    /**
     Returns the cell at a given row and column index.

     - parameter row: The cell's row index.
     - parameter column: The cell's column index.
     - parameter T: The type to cast this cell as. Callers can use `UIView` if the cell type is unknown.
     - returns: The cell at the given column and row index.
     */
    public func cellAt<T>(row rowIndex: Int, column columnIndex: Int) -> T? where T: UIView {
        guard rowIndex < rows.count else { return nil }
        let row = rows[rowIndex]
        guard columnIndex < row.count else { return nil }
        return row[columnIndex] as? T
    }

    // MARK: Internal

    private(set) var firstRowTopConstraints: [NSLayoutConstraint] = []
    private(set) var firstRowBottomConstraints: [NSLayoutConstraint] = []
    private(set) var firstColumnLeftConstraints: [NSLayoutConstraint] = []
    private(set) var firstColumnRightConstraints: [NSLayoutConstraint] = []
}
