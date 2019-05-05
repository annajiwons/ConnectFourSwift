//
//  GameState.swift
//  ConnectFour
//
//  Created by Anna Song on 2019-05-04.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import Foundation

enum GameState: Equatable {
    case win(winner: Int)
    case draw
    case ongoing
}

func ==(lhs: GameState, rhs: GameState) -> Bool {
    switch (lhs, rhs) {
    case let (.win(a), .win(b)):
        return a == b
    case (.draw, .draw):
        return true
    case (.ongoing, .ongoing):
        return true
    default:
        return false
    }
}
