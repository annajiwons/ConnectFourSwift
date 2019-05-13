//
//  ConnectFourAI.swift
//  ConnectFour
//
//  Created by Anna Song on 2019-05-07.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import Foundation

struct MinimaxSolver {
    
    private var game: ConnectFour
    
    private let realPlayer = 1
    private let ai = 2
    
    let threeInARowScore = 100.0
    let twoInARowScore = 10.0
    let oneInARowScore = 5.0
    
    init(game: ConnectFour) {
        self.game = game
    }
    
    
    // Minimax algorithm with alpha-beta pruning to choose the best column to play.
    mutating func minimax(for initialBoard: ConnectFour, withDepth depth: Int, alpha: Double, beta: Double, isMaximizingPlayer: Bool) -> (score: Double, column: Int?) {
        var board = initialBoard
        if (depth == 0 || board.checkWinOrDraw(for: realPlayer) == GameState.draw || board.checkWinOrDraw(for: realPlayer) == GameState.win || board.checkWinOrDraw(for: ai) == GameState.win) {
            if board.checkWinOrDraw(for: ai) == GameState.win {
                 return (100000000, nil)
            }
            if board.checkWinOrDraw(for: realPlayer) == GameState.win {
                return (-100000000, nil)
            }
            if board.checkWinOrDraw(for: realPlayer) == GameState.draw {
                return (0, nil)
            } else {
                return (scoreBoard(board: board), nil)
            }
        }
        if isMaximizingPlayer {
            var maxVal = -Double.infinity
            var columnToPlay = 0
            for column in game.getValidColumns() {
                var boardCopy = board
                _ = boardCopy.chooseColumn(at: column)
                boardCopy.switchToNextPlayer()
                let val = minimax(for: boardCopy, withDepth: depth - 1, alpha: alpha, beta: beta, isMaximizingPlayer: false).score
                if val > maxVal {
                    maxVal = val
                    columnToPlay = column
                }
                let newAlpha = Double.maximum(alpha, val)
                if newAlpha >= beta {
                    break
                }
            }
            return (maxVal, columnToPlay)
        } else {
            var minVal = Double.infinity
            var columnToPlay = 0
            for column in game.getValidColumns() {
                var boardCopy = board
                _ = boardCopy.chooseColumn(at: column)
                boardCopy.switchToNextPlayer()
                let val = minimax(for: boardCopy, withDepth: depth - 1, alpha: alpha, beta: beta, isMaximizingPlayer: true).score
                if val < minVal {
                    minVal = val
                    columnToPlay = column
                }
                let newBeta = Double.minimum(beta, val)
                if alpha >= newBeta {
                    break
                }
            }
            return (minVal, columnToPlay)
        }
    }
    
    // Gets heuristic value of board by adding scores from:
    //          three-in-a-row with one empty space,
    //          two-in-a-row   with two empty spaces,
    //          one-in-a-row   with three empty spaces
    // and subtracting the score of the opponent calculated in the same way
    func scoreBoard(board: ConnectFour) -> Double {
        return scoreHorizontal(board: board, for: ai) - scoreHorizontal(board: board, for: realPlayer) + scoreVertical(board: board, for: ai) - scoreVertical(board: board, for: realPlayer) + scoreLeftDownDiagonal(board: board, for: ai) - scoreLeftDownDiagonal(board: board, for: realPlayer) + scoreRightDownDiagonal(board: board, for: ai) - scoreRightDownDiagonal(board: board, for: realPlayer)
    }

    func scoreHorizontal(board: ConnectFour, for player: Int) -> Double {
        var boardCopy = board
        var score = 0.0
        for row in 0..<board.columnCapacity {
            for column in 0..<board.numColumns - 3 {
                let fourView: [Int?] =
                               [boardCopy.returnTile(column: column, row: row),
                                boardCopy.returnTile(column: column + 1, row: row),
                                boardCopy.returnTile(column: column + 2, row: row),
                                boardCopy.returnTile(column: column + 3, row: row)]
                score += addScores(fourView: fourView, player: player)
            }
        }
        return Double(score)
    }
    
    func scoreVertical(board: ConnectFour, for player: Int) -> Double {
        var boardCopy = board
        var score = 0.0
        for column in 0..<board.numColumns {
            for row in 0..<board.columnCapacity - 3 {
                let fourView: [Int?] =
                    [boardCopy.returnTile(column: column, row: row),
                     boardCopy.returnTile(column: column, row: row + 1),
                     boardCopy.returnTile(column: column, row: row + 2),
                     boardCopy.returnTile(column: column, row: row + 3)]
                score += addScores(fourView: fourView, player: player)
            }
        }
        return Double(score)
    }
    
    func scoreRightDownDiagonal(board: ConnectFour, for player: Int) -> Double {
        var boardCopy = board
        var score = 0.0
        for column in 0..<board.numColumns - 3 {
            for row in 0..<board.columnCapacity - 3 {
                let fourView: [Int?] =
                    [boardCopy.returnTile(column: column, row: row),
                     boardCopy.returnTile(column: column + 1, row: row + 1),
                     boardCopy.returnTile(column: column + 2, row: row + 2),
                     boardCopy.returnTile(column: column + 3, row: row + 3)]
                score += addScores(fourView: fourView, player: player)
            }
        }
        return Double(score)
    }
    
    func scoreLeftDownDiagonal(board: ConnectFour, for player: Int) -> Double {
        var boardCopy = board
        var score = 0.0
        for column in 0..<board.numColumns - 3 {
            for row in 0..<board.columnCapacity - 3 {
                let fourView: [Int?] =
                    [boardCopy.returnTile(column: column, row: row + 3),
                     boardCopy.returnTile(column: column + 1, row: row + 3 - 1),
                     boardCopy.returnTile(column: column + 2, row: row + 3 - 2),
                     boardCopy.returnTile(column: column + 3, row: row + 3 - 3)]
                score += addScores(fourView: fourView, player: player)
            }
        }
        return Double(score)
    }
    
    private func addScores(fourView: [Int?], player: Int) -> Double {
        var score = 0.0
        if (fourView.filter({$0 == player}).count == 3 && fourView.filter({$0 == nil}).count == 1) {
            score += threeInARowScore
        } else if (fourView.filter({$0 == player}).count == 2 && fourView.filter({$0 == nil}).count == 2) {
            score += twoInARowScore
        } else if (fourView.filter({$0 == player}).count == 1 && fourView.filter({$0 == nil}).count == 3) {
            score += oneInARowScore
        }
        return score
    }
}
