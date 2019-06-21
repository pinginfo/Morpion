//
//  ViewController.swift
//  Morpion
//
//  Created by Ping on 21.06.19.
//  Copyright © 2019 Ping. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnCase0: UIButton!
    @IBOutlet weak var btnCase1: UIButton!
    @IBOutlet weak var btnCase2: UIButton!
    @IBOutlet weak var btnCase3: UIButton!
    @IBOutlet weak var btnCase4: UIButton!
    @IBOutlet weak var btnCase5: UIButton!
    @IBOutlet weak var btnCase6: UIButton!
    @IBOutlet weak var btnCase7: UIButton!
    @IBOutlet weak var btnCase8: UIButton!
    @IBOutlet weak var btnRestart: UIButton!
    @IBOutlet weak var btnPlayerVsPlayer: UIButton!
    @IBOutlet weak var btnAI: UIButton!
    @IBOutlet weak var bar1: UIButton!
    @IBOutlet weak var bar2: UIButton!
    @IBOutlet weak var bar3: UIButton!
    @IBOutlet weak var bar4: UIButton!
    @IBOutlet weak var lblResult: UILabel!
    
    var btnAreShow: Bool = false
    var MorpionGame: Morpion!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialize the buttons
        let listButton: [UIButton] = [btnCase0, btnCase1, btnCase2, btnCase3, btnCase4, btnCase5, btnCase6, btnCase7, btnCase8]
        for button in listButton {
            button.addTarget(self, action: #selector(selectCase), for: .touchUpInside)
        }
        // Initialize the game
        MorpionGame = Morpion(cell: listButton, label: lblResult, reset: btnRestart, view: self)
        // Added rounding on the buttons
        bar1.layer.cornerRadius = 10
        bar2.layer.cornerRadius = 10
        bar3.layer.cornerRadius = 10
        bar4.layer.cornerRadius = 10
        showButton()
    }
    
    
    @objc func selectCase(sender: UIButton) {
        MorpionGame.cellPressed(sender: sender)
    }
    
    @IBAction func restart(_ sender: UIButton) {
        MorpionGame.newGame()
    }
    @IBAction func more(_ sender: UIButton) {
        if btnAreShow {
            UIView.animate(withDuration: 0.3) {
                self.hideButton()
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.showButton()
            }
        }
        btnAreShow = !btnAreShow
    }
    
    private func hideButton() {
        btnRestart.center = CGPoint(x: 50, y: btnRestart.center.y)
        btnPlayerVsPlayer.center = CGPoint(x: 50, y: btnPlayerVsPlayer.center.y)
        btnAI.center = CGPoint(x: 50, y: btnAI.center.y)
    }
    
    public func showButton() {
        btnRestart.center = CGPoint(x: 113, y: btnRestart.center.y)
        btnPlayerVsPlayer.center = CGPoint(x: 191, y: btnPlayerVsPlayer.center.y)
        btnAI.center = CGPoint(x: 269, y: btnAI.center.y)
    }
}

