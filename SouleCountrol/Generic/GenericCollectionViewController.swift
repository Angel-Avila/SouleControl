//
//  GenericCollectionViewController.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class GenericCollectionViewController<T: GenericCollectionViewCell<U>, U>: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Vars
    
    let reuseIdentifier = "id"
    var collectionViews = [UICollectionView]()
    var items = [[U]()]
    
    var screenWidth: CGFloat!
    
    var width: CGFloat!
    var height: CGFloat!
    var inset: CGFloat!
    
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
        width = screenWidth / 2
        height = AppDelegate.cellHeight
        inset = 20
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViews()
    }
    
    fileprivate func setupCollectionViews() {
        for (i, collectionView) in collectionViews.enumerated() {
            collectionView.register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
            
            let verticalSpacing: CGFloat = 8
            let horizontalSpacing: CGFloat = 16

            setupFlowLayout(forCollectionView: collectionView, width: width, height: height, spacing: horizontalSpacing, inset: inset)
            
            collectionView.anchorSize(size: CGSize(width: 0, height: 10 + height + verticalSpacing * 2))
            collectionView.showsHorizontalScrollIndicator = false
            
            collectionView.tag = i

            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    fileprivate func setupFlowLayout(forCollectionView collectionView: UICollectionView, width: CGFloat, height: CGFloat, spacing: CGFloat, inset: CGFloat) {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: width, height: height)
        flowLayout.minimumInteritemSpacing = spacing
        flowLayout.minimumLineSpacing = spacing
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        
        collectionView.setCollectionViewLayout(flowLayout, animated: false)
    }

    // MARK: UICollectionViewDataSource

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[collectionView.tag].count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! T
    
        cell.item = items[collectionView.tag][indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
