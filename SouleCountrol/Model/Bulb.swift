//
//  Bulb.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/22/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import Foundation

class Bulb: Device {
    var minutesOn: Int?
    var minutesLeft: Int?
    
    init(name: String = "", isOn: Bool = false) {
        super.init(name: name, type: .light, isOn: isOn)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.minutesOn = try container.decode(Int.self, forKey: .minutesOn)
        self.minutesLeft = try container.decode(Int.self, forKey: .minutesLeft)
        try super.init(from: decoder)
        self.type = .light
    }
    
    private enum CodingKeys: String, CodingKey {
        case minutesLeft
        case minutesOn
    }
}
