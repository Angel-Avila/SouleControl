//
//  UIView+shadow.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/6/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

extension UIView {
    static func giveStandardShadow(toView view: UIView) {
        view.layer.shadowColor = UIColor.darkText.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.3
    }
}
