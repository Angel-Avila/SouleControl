//
//  AnalyticsVC.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class AnalyticsVC: UICollectionViewController {
    
    init() {
        super.init(collectionViewLayout: UICollectionViewLayout())
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Title"
        self.navigationItem.title = "New title"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Analítica"
    }
}
