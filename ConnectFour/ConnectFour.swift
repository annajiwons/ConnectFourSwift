//
//  ConnectFour.swift
//  ConnectFour
//
//  Created by Anna Song on 2019-04-29.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import Foundation

struct ConnectFour
{
    private lazy var tiles = Array(repeating: [Int](), count: numColumns)
    private var currentPlayer = 1
    let columnCapacity: Int;
    let numColumns: Int;
    
    init(rows: Int, columns: Int) {
        columnCapacity = rows
        numColumns = columns
    }
    
    // Return the columns that are not yet full
    mutating func getValidColumns() -> [Int]{
        var validColumns = [Int]()
        for index in 0..<numColumns {
            if tiles[index].count < columnCapacity {
                validColumns.append(index)
            }
        }
        return validColumns
    }
    
    // Return the row at which the chip is inserted if successful, -1 if false
    mutating func chooseColumn(at index: Int) -> Int {
        var column = tiles[index]
        if column.count == columnCapacity {
            return -1
        }
        column.append(currentPlayer)
        tiles[index] = column
        return column.count - 1
    }
    
    mutating func returnTile(column x: Int, row y: Int) -> Int? {
        return tiles[x].count - 1 >= y ? tiles[x][y] : nil
    }
    
    func getCurrentPlayer() -> Int{
        return currentPlayer
    }
    
    mutating func switchToNextPlayer() {
        currentPlayer = currentPlayer == 1 ? 2 : 1
    }
    
    mutating func checkWinOrDraw(for player: Int) -> GameState {
        if isHorizontalWin(for: player) || isVerticalWin(for: player) || isDiagonalWin(for: player) {
            return GameState.win
        } else if (isDraw()) {
            return GameState.draw
        }
        return GameState.ongoing
    }
    
    private mutating func isHorizontalWin(for player: Int) -> Bool {
        for row in 0..<columnCapacity {
            var seenInARow = 0
            for column in 0..<numColumns {
                if tiles[column].count - 1 >= row && tiles[column][row] == player {
                    seenInARow += 1
                    if seenInARow == 4 {
                        return true
                    }
                } else {
                    seenInARow = 0
                }
            }
        }
        return false
    }
    
    private mutating func isVerticalWin(for player: Int) -> Bool {
        for column in 0..<numColumns {
            var seenInARow = 0
            for row in 0..<columnCapacity {
                if tiles[column].count - 1 >= row && tiles[column][row] == player {
                    seenInARow += 1
                    if seenInARow == 4 {
                        return true
                    }
                } else {
                    seenInARow = 0
                }
            }
        }
        return false
    }
    
    private mutating func isDiagonalWin(for player: Int) -> Bool {
        return isRightDownDiagonalWin(for: player) || isLeftDownDiagonalWin(for: player)
    }
    
    private mutating func isRightDownDiagonalWin(for player: Int) -> Bool {
        for coordSum in 0..<(columnCapacity + numColumns - 1) {
            let yMin = columnCapacity - min(columnCapacity - 1, coordSum) - 1
            let yMax = columnCapacity - max(0, coordSum - numColumns + 1) - 1
            var seenInARow = 0
            for y in yMin...yMax {
                let x = coordSum - columnCapacity + 1 + y
                if tiles[x].count - 1 >= y && tiles[x][y] == player {
                    seenInARow += 1
                    if (seenInARow == 4) {
                        return true
                    }
                } else {
                    seenInARow = 0
                }
            }
        }
        return false
    }
    
    private mutating func isLeftDownDiagonalWin(for player: Int) -> Bool {
        for coordSum in 0..<(columnCapacity + numColumns - 1) {
            let yMin = max(0, coordSum - numColumns + 1)
            let yMax = min(columnCapacity - 1, coordSum)
            var seenInARow = 0
            for y in yMin...yMax {
                let x = coordSum - y;
                if tiles[x].count - 1 >= y && tiles[x][y] == player {
                    seenInARow += 1
                    if (seenInARow == 4) {
                        return true
                    }
                } else {
                    seenInARow = 0
                }
            }
        }
        return false
    }
    
    private mutating func isDraw() -> Bool {
        for column in 0..<numColumns {
            if tiles[column].count < columnCapacity {
                return false
            }
        }
        return true
    }
    
}

