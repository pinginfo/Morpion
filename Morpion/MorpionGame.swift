//
//  Morpion_cellGame.swift
//  Morpion
//
//  Created by Ping on 21.06.19.
//  Copyright © 2019 Ping. All rights reserved.
//

import UIKit

class Morpion {
    private enum TypeCell {
        case Cicle
        case Cross
    }
    private struct Winner {
        var isTheFirstPlayer: Int
        var listButton: [UIButton]
    }
    private var _firstPlayerToPlay: Bool
    private var _cellGame: [Int]
    private var _partyIsEnded: Bool
    private var _cell: [UIButton]
    private var _btnReset: UIButton
    private var _shapeLayer: [CAShapeLayer]
    private var _resultLabel: UILabel
    private var _dictionary: [String]
    private var _view: ViewController
    
    init(cell: [UIButton], label: UILabel, reset: UIButton, view: ViewController) {
        // Initilization of variables
        _view = view
        _resultLabel = label
        _cell = cell
        _btnReset = reset
        _firstPlayerToPlay = true
        _cellGame = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
        _dictionary = ["Player 1 (Red)", "Player 2 (Blue)", "Computer", "Player 1 Win (Red)", "Player 2 Win (Blue)", "Computer Win", "Equality"]
        _shapeLayer = [CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer(), CAShapeLayer()]
        _partyIsEnded = false
        _resultLabel.text = _dictionary[0]
    }
    
    public func cellPressed(sender: UIButton) {
        if _firstPlayerToPlay && !_partyIsEnded && _cellGame[sender.tag] == -1 {
            turnOnCell(sender: sender, type: TypeCell.Cicle)
        } else if !_firstPlayerToPlay && !_partyIsEnded && _cellGame[sender.tag] == -1 {
            turnOnCell(sender: sender, type: TypeCell.Cross)
        } else if _partyIsEnded {
            _btnReset.pulsate(count: 1, maxValue: 2.5, minValue: 2)
        } else {
            return
        }
        _firstPlayerToPlay = !_firstPlayerToPlay
    }
    
    public func newGame() {
        // Clear variable
        _cellGame = [-1, -1, -1, -1, -1, -1, -1, -1, -1]
        _resultLabel.text = _dictionary[0]
        _partyIsEnded = false
        _firstPlayerToPlay = true
        
        // Clear button
        // Need to make an animation when the user cleans the grid ⚠
        let basicAnimation = CABasicAnimation(keyPath: "opacity")
        basicAnimation.toValue = 0
        basicAnimation.duration = 2
        for shape in _shapeLayer {
            shape.add(basicAnimation, forKey: "basicAnim")
        }
    }
    
    private func turnOnCell(sender: UIButton, type: TypeCell) {
        if type == TypeCell.Cicle {
            drawCircle(button: sender)
            // Why i can't get the id of the enum 😭
            _resultLabel.text = _dictionary[1]
            _cellGame[sender.tag] = 0
        } else {
            drawCross(button: sender)
            _resultLabel.text = _dictionary[0]
            _cellGame[sender.tag] = 1
        }
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 1
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        _shapeLayer[sender.tag].add(basicAnimation, forKey: "basicAnim")
        checkResult()
    }
    
    private func drawCircle(button: UIButton) {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: button.frame.size.width/2, y: button.frame.size.height/2), radius: button.frame.size.width/2.5, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        _shapeLayer[button.tag].path = circlePath.cgPath
        
        _shapeLayer[button.tag].fillColor = UIColor.clear.cgColor
        _shapeLayer[button.tag].strokeColor = UIColor.red.cgColor
        _shapeLayer[button.tag].lineWidth = 5
        _shapeLayer[button.tag].strokeEnd = 0
        
        button.layer.addSublayer(_shapeLayer[button.tag])
    }
    
    private func drawCross(button: UIButton) {
        let crossPath = UIBezierPath(arcCenter: CGPoint(x: button.frame.size.width/2, y: button.frame.size.height/2), radius: button.frame.size.width/2.5, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true)
        _shapeLayer[button.tag].path = crossPath.cgPath
        
        _shapeLayer[button.tag].fillColor = UIColor.clear.cgColor
        _shapeLayer[button.tag].strokeColor = UIColor.blue.cgColor
        _shapeLayer[button.tag].lineWidth = 5
        _shapeLayer[button.tag].strokeEnd = 0
        
        button.layer.addSublayer(_shapeLayer[button.tag])
    }
    
    private func checkResult() {
        if _cellGame[0] == _cellGame[1] && _cellGame[1] == _cellGame[2] && _cellGame[0] != -1 {
            showEndingParty(winner: Winner(isTheFirstPlayer: _cellGame[0], listButton: [_cell[0], _cell[1], _cell[2]]))
        } else if _cellGame[3] == _cellGame[4] && _cellGame[4] == _cellGame[5] && _cellGame[3] != -1  {
            showEndingParty(winner: Winner(isTheFirstPlayer: _cellGame[3], listButton: [_cell[3], _cell[4], _cell[5]]))
        } else if _cellGame[6] == _cellGame[7] && _cellGame[6] == _cellGame[8] && _cellGame[6] != -1  {
            showEndingParty(winner: Winner(isTheFirstPlayer: _cellGame[6], listButton: [_cell[6], _cell[7], _cell[8]]))
        } else if _cellGame[0] == _cellGame[3] && _cellGame[3] == _cellGame[6] && _cellGame[0] != -1 {
            showEndingParty(winner: Winner(isTheFirstPlayer: _cellGame[0], listButton: [_cell[0], _cell[3], _cell[6]]))
        } else if _cellGame[1] == _cellGame[4] && _cellGame[4] == _cellGame[7] && _cellGame[1] != -1  {
            showEndingParty(winner: Winner(isTheFirstPlayer: _cellGame[1], listButton: [_cell[1], _cell[4], _cell[7]]))
        } else if _cellGame[2] == _cellGame[5] && _cellGame[5] == _cellGame[8] && _cellGame[2] != -1  {
            showEndingParty(winner: Winner(isTheFirstPlayer: _cellGame[2], listButton: [_cell[2], _cell[5], _cell[8]]))
        } else if _cellGame[0] == _cellGame[4] && _cellGame[4] == _cellGame[8] && _cellGame[0] != -1  {
            showEndingParty(winner: Winner(isTheFirstPlayer: _cellGame[0], listButton: [_cell[0], _cell[4], _cell[8]]))
        } else if _cellGame[2] == _cellGame[4] && _cellGame[4] == _cellGame[6] && _cellGame[2] != -1  {
            showEndingParty(winner: Winner(isTheFirstPlayer: _cellGame[2], listButton: [_cell[2], _cell[4], _cell[6]]))
        } else {
            var all: Bool = true
            for cell in _cellGame {
                if cell == -1 {
                    all = false
                }
            }
            if all {
                _resultLabel.text = _dictionary[6]
                _partyIsEnded = true
                _btnReset.pulsate(count: 1, maxValue: 2.5, minValue: 2)
            }
        }
    }
    
    private func showEndingParty(winner: Winner) {
        _view.showButton() // Why doesn't work 😰
        _resultLabel.text = _dictionary[winner.isTheFirstPlayer + 3]
        _partyIsEnded = true
        _btnReset.pulsate(count: 1, maxValue: 2.5, minValue: 2)
        for btn in winner.listButton {
            btn.pulsate(count: 1, maxValue: 1.05, minValue: 1)
        }
    }
}
