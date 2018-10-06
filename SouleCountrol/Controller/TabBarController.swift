//
//  TabBarController.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let devicesVC = DevicesVC(screenWidth: view.bounds.width)
        devicesVC.tabBarItem = UITabBarItem(title: "Dispositivos", image: #imageLiteral(resourceName: "home"), tag: 0)
        
        let analyticsVC = AnalyticsVC()
        analyticsVC.tabBarItem = UITabBarItem(title: "Dashboard", image: #imageLiteral(resourceName: "dashboard"), tag: 1)
        
        let securityVC = SecurityVC()
        securityVC.tabBarItem = UITabBarItem(title: "Seguridad", image: #imageLiteral(resourceName: "security"), tag: 2)
        
        let tabList = [devicesVC, analyticsVC, securityVC]
        
        viewControllers = tabList
    }
}
