//
//  PopUpViewController.swift
//  ConnectFour
//
//  Created by Anna Song on 2019-05-05.
//  Copyright © 2019 Anna Song. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    private var text: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        textLabel.text = text
        showAnimate()
    }
    
    @IBOutlet weak var textLabel: UILabel!
    @IBAction func closePopUp(_ sender: UIButton) {
        removeAnimate()
    }
    
    public func setText(to message: String){
        text = message
    }
    
    private func showAnimate()
    {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        });
    }
    
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
