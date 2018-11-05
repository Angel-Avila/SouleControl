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
    var hoursArrivedAt = [Double]()
    
    var image = #imageLiteral(resourceName: "person")
    
    init(name: String, image: UIImage = #imageLiteral(resourceName: "person")) {
        self.name = name
        self.image = image
    }
}
