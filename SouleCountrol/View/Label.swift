//
//  Label.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/11/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class Label: UILabel {
    
    init(labelText: String, fontName: String = "AvenirNext-Regular", size: CGFloat, textColor: UIColor) {
        super.init(frame: .zero)
        
        self.font = UIFont(name: fontName, size: size)
        self.text = labelText
        self.textColor = textColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.numberOfLines = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
