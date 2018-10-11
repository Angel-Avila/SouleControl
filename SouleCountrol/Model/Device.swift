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

enum DoorState: String {
    case on = "Abierta"
    case off = "Cerrada"
}

enum CameraState: String {
    case on = "Transmitiendo"
    case off = "Apagada"
}

enum LightState: String {
    case on = "Prendido"
    case off = "Apagado"
}

class Device {
    
    var name: String!
    var type: DeviceType!
    var state: String!
    var isOn: Bool!
    
    init(name: String, type: DeviceType, state: String = "-", isOn: Bool = false) {
        self.name = name
        self.type = type
        self.state = state
        self.isOn = isOn
    }
    
}
