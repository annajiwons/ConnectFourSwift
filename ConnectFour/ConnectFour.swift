//
//  ConnectFour.swift
//  ConnectFour
//
//  Created by Anna Song on 2019-04-29.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import Foundation

class ConnectFour
{
    private lazy var tiles = Array(repeating: [Int](), count: numColumns)
    private var currentPlayer = 1
    private let columnCapacity: Int;
    private let numColumns: Int;
    
    init(rows: Int, columns: Int) {
        columnCapacity = rows
        numColumns = columns
    }
    
    // Return the row at which the chip is inserted if successful, -1 if false
    func chooseColumn(at index: Int) -> Int {
        var column = tiles[index]
        if column.count == columnCapacity {
            return -1
        }
        column.append(currentPlayer)
        tiles[index] = column
        return column.count - 1
    }
    
    func getCurrentPlayer() -> Int{
        return currentPlayer
    }
    
    func switchToNextPlayer() {
        currentPlayer = currentPlayer == 1 ? 2 : 1
    }
    
    func checkGameState() -> GameState {
        if isHorizontalWin() || isVerticalWin() || isDiagonalWin() {
            return GameState.win(winner: currentPlayer)
        } else if (isDraw()) {
            return GameState.draw
        }
        return GameState.ongoing
    }
    
    private func isHorizontalWin() -> Bool {
        for row in 0..<columnCapacity {
            var seenInARow = 0
            for column in 0..<numColumns {
                if tiles[column].count - 1 >= row && tiles[column][row] == currentPlayer {
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
    
    private func isVerticalWin() -> Bool {
        for column in 0..<numColumns {
            var seenInARow = 0
            for row in 0..<columnCapacity {
                if tiles[column].count - 1 >= row && tiles[column][row] == currentPlayer {
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
    
    private func isDiagonalWin() -> Bool {
        return isRightDownDiagonalWin() || isLeftDownDiagonalWin()
    }
    
    private func isRightDownDiagonalWin() -> Bool {
        for coordSum in 0..<(columnCapacity + numColumns - 1) {
            let yMin = columnCapacity - min(columnCapacity - 1, coordSum) - 1
            let yMax = columnCapacity - max(0, coordSum - numColumns + 1) - 1
            var seenInARow = 0
            for y in yMin...yMax {
                let x = coordSum - columnCapacity + 1 + y
                if tiles[x].count - 1 >= y && tiles[x][y] == currentPlayer {
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
    
    private func isLeftDownDiagonalWin() -> Bool {
        for coordSum in 0..<(columnCapacity + numColumns - 1) {
            let yMin = max(0, coordSum - numColumns + 1)
            let yMax = min(columnCapacity - 1, coordSum)
            var seenInARow = 0
            for y in yMin...yMax {
                let x = coordSum - y;
                if tiles[x].count - 1 >= y && tiles[x][y] == currentPlayer {
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
    
    private func isDraw() -> Bool {
        for column in 0..<numColumns {
            if tiles[column].count < columnCapacity {
                return false
            }
        }
        return true
    }
    
}

