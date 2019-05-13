//
//  ModePopUpViewController.swift
//  ConnectFour
//
//  Created by Anna Song on 2019-05-07.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import UIKit

class StartPopUpViewController: UIViewController {
    
    private var isOnePlayer: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func chooseMode(_ sender: UIButton) {
        isOnePlayer = sender.tag == 0 ? true : false
        performSegue(withIdentifier: "mode", sender: self)
        removeAnimate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameVc = segue.destination as! ViewController
        gameVc.isOnePlayer = isOnePlayer
    }
    
    // From https://github.com/awseeley/Swift-Pop-Up-View-Tutorial
    private func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
}
