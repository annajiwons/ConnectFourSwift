//
//  GameState.swift
//  ConnectFour
//
//  Created by Anna Song on 2019-05-04.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import Foundation

enum GameState: Equatable {
    case win
    case draw
    case ongoing
}

func ==(lhs: GameState, rhs: GameState) -> Bool {
    switch (lhs, rhs) {
    case (.win, .win):
        return true
    case (.draw, .draw):
        return true
    case (.ongoing, .ongoing):
        return true
    default:
        return false
    }
}
