//
//  Cam.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/22/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import Foundation

class Cam: Device {
    var minutesOn: Int?
    
    init(name: String = "", isOn: Bool = false, minutesOn: Int? = nil) {
        self.minutesOn = minutesOn
        super.init(name: name, type: .camera, isOn: isOn)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.minutesOn = try container.decode(Int.self, forKey: .minutesOn)
        try super.init(from: decoder)
        self.type = .camera
    }
    
    private enum CodingKeys: String, CodingKey {
        case minutesOn
    }
}
