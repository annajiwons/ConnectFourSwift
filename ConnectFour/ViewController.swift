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
    
    private var playerIcons = [1: "🔴", 2: "🔵"]
    
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
        let column = getColumnFromTag(with: sender.tag)
        let row = game.chooseColumn(at: column)
        if (row != -1) {
            updateViewFromModel(at: column, at: row)
        }
    }
    
    private func updateViewFromModel(at column: Int, at row: Int) {
        let player = game.getCurrentPlayer()
        var buttonsInColumn = buttons.filter{getColumnFromTag(with: $0.tag) == column}.sorted(by: {$0.tag < $1.tag})
        buttonsInColumn[row].setTitle(playerIcons[player], for: UIControl.State.normal)
        let gameState = game.checkGameState()
        if (gameState == GameState.win(winner: player)) {
            showGameOverPopUpAndReset(withMessage: "Player \(player) won!")
        } else if (gameState == GameState.draw){
            showGameOverPopUpAndReset(withMessage: "Draw!")
        }
        game.switchToNextPlayer()
    }
    
    private func showGameOverPopUpAndReset(withMessage message: String) {
        let popUpViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "popUpSb") as! PopUpViewController
        popUpViewController.setText(to: message)
        self.addChild(popUpViewController)
        popUpViewController.view.frame = self.view.frame
        self.view.addSubview(popUpViewController.view)
        popUpViewController.didMove(toParent: self)
        game = ConnectFour(rows: numRows, columns: numColumns)
        clearBoard()
    }
    
    private func clearBoard() {
        for button in buttons {
            button.setTitle("", for: UIControl.State.normal)
        }
    }
    
    private func getColumnFromTag(with tag: Int) -> Int {
        return tag % numRows == 0 ? tag / numRows - 1 : tag / numRows
    }
}

