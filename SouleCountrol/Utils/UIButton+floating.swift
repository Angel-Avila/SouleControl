//
//  UIButton+floating.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/11/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

extension UIButton {
    static func createFloatingButton(height: CGFloat, image: UIImage, buttonColor: UIColor, borderColor: UIColor, tintColor: UIColor?, inset: CGFloat) -> UIButton {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = buttonColor
        
        if let tintColor = tintColor {
            button.tintColor = tintColor
        }
        
        button.setImage(image, for: .normal)
        
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.imageView?.contentMode = .scaleAspectFit
        
        button.imageEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        button.layer.cornerRadius = height/2
        
        UIView.giveStandardShadow(toView: button)
        
        button.layer.borderWidth = 2
        button.layer.borderColor = borderColor.cgColor
        
        button.titleLabel?.text = " "
        
        return button
    }
    
    static func createFloatingButton(height: CGFloat, text: String, font: UIFont, buttonColor: UIColor, borderColor: UIColor, tintColor: UIColor?) -> UIButton {
        
        let button = UIButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = buttonColor
        
        if let tintColor = tintColor {
            button.tintColor = tintColor
        }
        
        button.contentHorizontalAlignment = .center
        
        button.layer.cornerRadius = height/2
        
        UIView.giveStandardShadow(toView: button)
        
        button.layer.borderWidth = 2
        button.layer.borderColor = borderColor.cgColor
        
        button.setTitle(text, for: .normal)
        
        button.titleLabel?.font = font
        
        return button
    }
    
    static func setRoundButtonSize(_ button: UIButton,withHeight height: CGFloat) {
        button.layer.cornerRadius = height / 2
        button.heightAnchor.constraint(equalToConstant: height).isActive = true
        button.widthAnchor.constraint(equalToConstant: height).isActive = true
    }
}
