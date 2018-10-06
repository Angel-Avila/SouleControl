//
//  UIView+gradient.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/6/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

extension UIView {
    func setHorizontalGradient(color1: String, color2: String, withCornerRadius radius: CGFloat = 0) {
        setHorizontalGradient(color1: UIColor(hex: color1), color2: UIColor(hex: color2), withCornerRadius: radius)
    }
    
    func setHorizontalGradient(color1: UIColor, color2: UIColor, withCornerRadius radius: CGFloat = 0) {
        let gradient = CAGradientLayer()
        gradient.colors = [color1.cgColor, color2.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        gradient.cornerRadius = radius
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}
