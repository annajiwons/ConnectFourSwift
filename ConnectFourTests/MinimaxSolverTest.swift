//
//  MinimaxSolverTest.swift
//  ConnectFourTests
//
//  Created by Anna Song on 2019-05-11.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import XCTest

class MinimaxSolverTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testScoreHorizontal() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 3)
        _ = game.chooseColumn(at: 3)
        _ = game.chooseColumn(at: 3)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 3)
        let solver = MinimaxSolver(game: game)
        XCTAssertTrue(solver.scoreHorizontal(board: game, for: 1) == solver.oneInARowScore * 3)
        XCTAssertTrue(solver.scoreHorizontal(board: game, for: 2) == solver.oneInARowScore)
    }
    
    func testScoreVertical() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 2)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 3)
        let solver = MinimaxSolver(game: game)
        XCTAssertTrue(solver.scoreVertical(board: game, for: 1) == solver.oneInARowScore * 3)
        XCTAssertTrue(solver.scoreVertical(board: game, for: 2) == solver.oneInARowScore)
    }
    
    func testScoreRightDownDiagonal() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 2)
        _ = game.chooseColumn(at: 2)
        _ = game.chooseColumn(at: 2)
        let solver = MinimaxSolver(game: game)
        XCTAssertTrue(solver.scoreRightDownDiagonal(board: game, for: 1) == solver.threeInARowScore)
        XCTAssertTrue(solver.scoreRightDownDiagonal(board: game, for: 2) == 0)
    }
    
    func testScoreLeftDownDiagonal() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 2)
        _ = game.chooseColumn(at: 2)
        _ = game.chooseColumn(at: 3)
        let solver = MinimaxSolver(game: game)
        XCTAssertTrue(solver.scoreLeftDownDiagonal(board: game, for: 1) == solver.threeInARowScore)
        XCTAssertTrue(solver.scoreLeftDownDiagonal(board: game, for: 2) == 0)
    }

    func testShouldBlockHorizontalWin() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 2)
        game.switchToNextPlayer()
        var solver = MinimaxSolver(game: game)
        let solverResult = solver.minimax(for: game, withDepth: 1, alpha: -Double.infinity, beta: Double.infinity, isMaximizingPlayer: true)
        XCTAssertTrue(solverResult.column == 3)
    }
    
    func testShouldBlockVerticalWin() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 0)
        game.switchToNextPlayer()
        var solver = MinimaxSolver(game: game)
        let solverResult = solver.minimax(for: game, withDepth: 1, alpha: -Double.infinity, beta: Double.infinity, isMaximizingPlayer: true)
        XCTAssertTrue(solverResult.column == 0)
    }
    
    func testShouldBlockRightDownDiagonalWin() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 2)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 2)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 2)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 3)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 3)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 3)
        var solver = MinimaxSolver(game: game)
        let solverResult = solver.minimax(for: game, withDepth: 2, alpha: -Double.infinity, beta: Double.infinity, isMaximizingPlayer: true)
        XCTAssertTrue(solverResult.column == 3)
    }
    
    func testShouldBlockLeftDownDiagonalWin() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 3)
        _ = game.chooseColumn(at: 2)
        _ = game.chooseColumn(at: 2)
        _ = game.chooseColumn(at: 1)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 1)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 1)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 0)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 0)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 0)
        var solver = MinimaxSolver(game: game)
        let solverResult = solver.minimax(for: game, withDepth: 2, alpha: -Double.infinity, beta: Double.infinity, isMaximizingPlayer: true)
        XCTAssertTrue(solverResult.column == 0)
    }
    
    func testOpponentAbsoluteWinReturnsFirstValidColumn() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 1)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 2)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 2)
        _ = game.chooseColumn(at: 2)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 3)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 3)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 3)
        var solver = MinimaxSolver(game: game)
        let solverResult = solver.minimax(for: game, withDepth: 2, alpha: -Double.infinity, beta: Double.infinity, isMaximizingPlayer: true)
        XCTAssertTrue(solverResult.column == 0)
    }
    
    func testShouldBlockHorizontalThreeInARow() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 2)
        game.switchToNextPlayer()
        var solver = MinimaxSolver(game: game)
        let solverResult = solver.minimax(for: game, withDepth: 2, alpha: -Double.infinity, beta: Double.infinity, isMaximizingPlayer: true)
        XCTAssertTrue(solverResult.column == 0)
    }
    
    func testShouldBlockVerticalThreeInARow() {
        var game = ConnectFour(rows: 4, columns: 4)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 1)
        game.switchToNextPlayer()
        var solver = MinimaxSolver(game: game)
        let solverResult = solver.minimax(for: game, withDepth: 2, alpha: -Double.infinity, beta: Double.infinity, isMaximizingPlayer: true)
        XCTAssertTrue(solverResult.column == 1)
    }
}
