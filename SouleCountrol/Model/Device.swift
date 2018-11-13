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

class Device: Decodable {
    
    let _id: String!
    var name: String!
    var type: DeviceType!
    var isOn: Bool!
    
    init(_id: String = "", name: String, type: DeviceType, isOn: Bool = false) {
        self._id = _id
        self.name = name
        self.type = type
        self.isOn = isOn
    }
    
    private enum CodingKeys: String, CodingKey {
        case name
        case isOn
        case _id
    }
    
}
