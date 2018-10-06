//
//  HeaderView.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/6/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    lazy var label: UILabel! = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: ".SFUIDisplay-Bold", size: 24)
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        label.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 4, left: 4, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
