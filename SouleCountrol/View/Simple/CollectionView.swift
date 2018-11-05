//
//  CollectionView.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/6/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView, UIGestureRecognizerDelegate {

    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        panGestureRecognizer.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
