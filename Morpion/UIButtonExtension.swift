//
//  UIButton.swift
//  Morpion
//
//  Created by Ping on 21.06.19.
//  Copyright © 2019 Ping. All rights reserved.
//

import UIKit

extension UIButton {
    func pulsate(count: Float, maxValue: Float, minValue: Float) {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.6
        pulse.fromValue = minValue
        pulse.toValue = maxValue
        pulse.autoreverses = true
        pulse.repeatCount = count
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
}
