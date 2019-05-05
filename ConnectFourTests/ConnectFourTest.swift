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
        XCTAssertTrue(game.checkGameState() == GameState.win(winner: 1))
    }
    
    func testVerticalWin() {
        makeEqualPlays(forPlayerOne: [0, 0, 0, 0], forPlayerTwo: [6, 6, 6, 1])
        XCTAssertTrue(game.checkGameState() == GameState.win(winner: 1))
    }
    
    func testDiagonalRightDownWin() {
        makeEqualPlays(forPlayerOne: [3, 2, 1, 1, 0, 0], forPlayerTwo: [2, 1, 0, 0, 6, 6])
        XCTAssertTrue(game.checkGameState() == GameState.win(winner: 1))
    }
    
    func testDiagonalLeftDownWin() {
        makeEqualPlays(forPlayerOne: [0, 1, 2, 2, 3, 3], forPlayerTwo: [1, 2, 3, 3, 6, 6])
        XCTAssertTrue(game.checkGameState() == GameState.win(winner: 1))
    }
    
    func testDraw() {
        let game = ConnectFour(rows: 2, columns: 2)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 0)
        _ = game.chooseColumn(at: 1)
        _ = game.chooseColumn(at: 1)
        XCTAssertTrue(game.checkGameState() == GameState.draw)
    }
    
    private func makeEqualPlays(forPlayerOne p1: [Int], forPlayerTwo p2: [Int]) {
        for index in p1.indices {
            _ = game.chooseColumn(at: p1[index])
            _ = game.chooseColumn(at: p2[index])
        }
    }

}

