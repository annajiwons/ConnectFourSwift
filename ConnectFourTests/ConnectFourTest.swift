//
//  ConnectFourTest.swift
//  ConnectFourTests
//
//  Created by Anna Song on 2019-04-29.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import XCTest

class ConnectFourTest: XCTestCase {
    var game: ConnectFour!
    
    override func setUp() {
        game = ConnectFour(rows: 6, columns: 7)
    }
    
    func testHorizontalWin() {
        makeEqualPlays(forPlayerOne: [0, 1, 2, 3], forPlayerTwo: [6, 6, 6, 6])
        XCTAssertTrue(game.checkWinOrDraw(for: 1) == GameState.win)
    }
    
    func testVerticalWin() {
        makeEqualPlays(forPlayerOne: [0, 0, 0, 0], forPlayerTwo: [6, 6, 6, 1])
        XCTAssertTrue(game.checkWinOrDraw(for: 1) == GameState.win)
    }
    
    func testDiagonalRightDownWin() {
        makeEqualPlays(forPlayerOne: [3, 2, 1, 1, 0, 0], forPlayerTwo: [2, 1, 0, 0, 6, 6])
        XCTAssertTrue(game.checkWinOrDraw(for: 1) == GameState.win)
    }
    
    func testDiagonalLeftDownWin() {
        makeEqualPlays(forPlayerOne: [0, 1, 2, 2, 3, 3], forPlayerTwo: [1, 2, 3, 3, 6, 6])
        XCTAssertTrue(game.checkWinOrDraw(for: 1) == GameState.win)
    }
    
    func testDraw() {
        var game = ConnectFour(rows: 2, columns: 2)
        _ = game.chooseColumn(at: 0)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 0)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 1)
        game.switchToNextPlayer()
        _ = game.chooseColumn(at: 1)
        XCTAssertTrue(game.checkWinOrDraw(for: 1) == GameState.draw)
    }
    
    private func makeEqualPlays(forPlayerOne p1: [Int], forPlayerTwo p2: [Int]) {
        for index in p1.indices {
            _ = game.chooseColumn(at: p1[index])
           game.switchToNextPlayer()
            _ = game.chooseColumn(at: p2[index])
            game.switchToNextPlayer()
        }
    }

}

