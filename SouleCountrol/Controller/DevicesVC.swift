//
//  DevicesVC.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class DevicesVC: GenericCollectionViewController<DeviceCell, Device>, UIGestureRecognizerDelegate {

    let devices = [[Device(name: "Recámara", type: .light), Device(name: "Sala", type: .light), Device(name: "Recámara principal papás", type: .light), Device(name: "Sala", type: .light), Device(name: "Recámara", type: .light), Device(name: "Sala", type: .light), Device(name: "Recámara", type: .light), Device(name: "Sala", type: .light)],
                   
                   [Device(name: "Entrada", type: .door), Device(name: "Baño principal", type: .door)],
                   
                   [Device(name: "Entrada principal", type: .camera)],
                   
                   [Device(name: "Entrada", type: .extra), Device(name: "Baño principal", type: .extra)]]
    
    let scrollView = ScrollView()
    
    let lightsCollectionView = CollectionView()
    let doorsCollectionView = CollectionView()
    let camerasCollectionView = CollectionView()
    let randomCollectionView = CollectionView()
    
    let lightsHeader = HeaderView()
    let doorsHeader = HeaderView()
    let camerasHeader = HeaderView()
    let randomHeader = HeaderView()
    
    let interItemSpacing: CGFloat = 32
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        collectionViews = [lightsCollectionView, doorsCollectionView, camerasCollectionView, randomCollectionView]
        
        items = devices
        
        super.viewDidLoad()
  
        setupViews()
    }
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        
        setupCollectionViews()
    }
    
    fileprivate func setupCollectionViews() {
        setupLightsCollectionView()
        setupDoorsCollectionView()
        setupCamerasCollectionView()
        setupRandomCollectionView()
        anchorBottomCollectionView()
    }
    
    fileprivate func setupLightsCollectionView() {
        lightsHeader.label.text = "Luces"
        setupCollectionView(lightsCollectionView, withHeader: lightsHeader, belowView: scrollView, withTopPadding: 10)
    }
    
    fileprivate func setupDoorsCollectionView() {
        doorsHeader.label.text = "Puertas"
        setupCollectionView(doorsCollectionView, withHeader: doorsHeader, belowView: lightsCollectionView, withTopPadding: interItemSpacing)
    }
    
    fileprivate func setupCamerasCollectionView() {
        camerasHeader.label.text = "Cámaras"
        setupCollectionView(camerasCollectionView, withHeader: camerasHeader, belowView: doorsCollectionView, withTopPadding: interItemSpacing)
    }
    
    fileprivate func setupRandomCollectionView() {
        randomHeader.label.text = "Dispositivos extra"
        setupCollectionView(randomCollectionView, withHeader: randomHeader, belowView: camerasCollectionView, withTopPadding: interItemSpacing)
    }
    
    fileprivate func setupCollectionView(_ collectionView: UICollectionView, withHeader header: UIView, belowView bView: UIView, withTopPadding topPadding: CGFloat) {
        
        scrollView.addSubview(header)
        scrollView.addSubview(collectionView)
        
        if bView == scrollView {
            header.anchor(top: bView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0), size: CGSize(width: 200, height: 40))
        } else {
            header.anchor(top: bView.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0), size: CGSize(width: 200, height: 40))
        }
        
        collectionView.anchor(top: header.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor)
        collectionView.anchorSize(size: CGSize(width: view.bounds.width, height: 0))
    }
    
    fileprivate func anchorBottomCollectionView() {
        guard let collectionView = collectionViews.last else { return }
        print(collectionView == randomCollectionView)
        collectionView.anchor(top: nil, leading: nil, bottom: scrollView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Dispositivos"
    }
    

    
}
