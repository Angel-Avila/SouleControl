//
//  Utils.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/11/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class Utils {
    static func phoneHasNotch() -> Bool {
        let h = UIScreen.main.nativeBounds.height
        
        if h == 2436 || h == 2688 || h == 1792 {
            return true
        }
        
        return false
    }
}
