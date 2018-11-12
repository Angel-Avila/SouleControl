//
//  Door.swift
//  SouleCountrol
//
//  Created by Angel Avila on 11/11/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import Foundation

class Door: Device {
    
    init(name: String = "", isOn: Bool = false) {
        super.init(name: name, type: .door, isOn: isOn)
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
}

