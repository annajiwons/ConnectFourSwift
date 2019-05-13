//
//  ViewController.swift
//  ConnectFour
//
//  Created by Anna Song on 2019-04-29.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = ConnectFour(rows: numRows, columns: numColumns)
    private let playerIcons = [1: "🔴", 2: "🔵"]
    
    var isOnePlayer = false
    private lazy var connectFourAi = isOnePlayer ? MinimaxSolver(game: game) : nil
    private var aiThinking = false
    
    private let numColumns = 7
    private let numRows = 6
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in buttons {
            button.setTitle("", for: UIControl.State.normal)
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    @IBAction private func touchColumn(_ sender: UIButton) {
        if (!aiThinking) {
            let column = getColumnFromTag(with: sender.tag)
            let row = game.chooseColumn(at: column)
            if (row != -1) {
                updateViewFromModel(at: column, at: row)
            }
            if (isOnePlayer && game.getCurrentPlayer() == 2) {
                aiThinking = true
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.aiTurn()
                    self.aiThinking = false
                }
            }
        }
    }
    
    private func aiTurn() {
        let column = connectFourAi?.minimax(for: game, withDepth: 4, alpha: -Double.infinity, beta: Double.infinity, isMaximizingPlayer: true).column
        let row = (column != nil) ? game.chooseColumn(at: column!) : game.chooseColumn(at: game.getValidColumns()[0])
        if (row != -1) {
            updateViewFromModel(at: column!, at: row)
        }
    }
    
    private func updateViewFromModel(at column: Int, at row: Int) {
        let player = game.getCurrentPlayer()
        var buttonsInColumn = buttons.filter{getColumnFromTag(with: $0.tag) == column}.sorted(by: {$0.tag < $1.tag})
        buttonsInColumn[row].setTitle(playerIcons[player], for: UIControl.State.normal)
        let gameState = game.checkWinOrDraw(for: player)
        if (gameState == GameState.win) {
            showGameOverPopUpAndReset(withMessage: "Player \(player) won!")
        } else if (gameState == GameState.draw){
            showGameOverPopUpAndReset(withMessage: "Draw!")
        } else {
            game.switchToNextPlayer()
        }
    }
    
    private func getColumnFromTag(with tag: Int) -> Int {
        return tag % numRows == 0 ? tag / numRows - 1 : tag / numRows
    }
    
    private func showGameOverPopUpAndReset(withMessage message: String) {
        let popUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpSb") as! EndPopUpViewController
        popUpViewController.setText(to: message)
        self.addChild(popUpViewController)
        popUpViewController.view.frame = self.view.frame
        self.view.addSubview(popUpViewController.view)
        popUpViewController.didMove(toParent: self)
        game = ConnectFour(rows: numRows, columns: numColumns)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.clearBoard()
        }
    }
    
    private func clearBoard() {
        for button in buttons {
            button.setTitle("", for: UIControl.State.normal)
        }
    }
}

