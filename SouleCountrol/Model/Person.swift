//
//  Person.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/11/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class Person {
    
    var name: String!
    var role: String!
    
    var image = #imageLiteral(resourceName: "person")
    
    init(name: String, role: String) {
        self.name = name
        self.role = role
    }
}
