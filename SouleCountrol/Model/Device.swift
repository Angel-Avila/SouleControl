//
//  Device.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import Foundation

enum DeviceType {
    case light
    case door
    case camera
    case extra
}

class Device {
    
    var name: String!
    var type: DeviceType!
    
    init(name: String, type: DeviceType) {
        self.name = name
        self.type = type
    }
    
}
