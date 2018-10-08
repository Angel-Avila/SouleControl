//
//  DevicesVC.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class DevicesVC: GenericCollectionViewController<DeviceCell, Device>, UIGestureRecognizerDelegate {

    let devices = [[Device(name: "Foco 1", type: .light, state: "Prendido"), Device(name: "Foco 2", type: .light, state: "Apagado")],
                   
                   [Device(name: "Foco", type: .light, state: "Apagado"), Device(name: "Termómetro", type: .extra, state: "28°C")],
                   
                   [Device(name: "Cámara", type: .camera, state: "Apagada"), Device(name: "Puerta principal", type: .door, state: "Cerrada"), Device(name: "Foco exterior", type: .light, state: "Prendido"), Device(name: "Foco interior", type: .light, state: "Apagado")],
                   
                   [Device(name: "Puerta del cuarto", type: .door, state: "Abierta"), Device(name: "Foco", type: .light, state: "Apagado")]]
    
    let scrollView = ScrollView()
    
    let livingRoomCollectionView = CollectionView()
    let kitchenCollectionView = CollectionView()
    let entranceCollectionView = CollectionView()
    let bedroomCollectionView = CollectionView()
    
    let livingRoomHeader = HeaderView()
    let kitchenHeader = HeaderView()
    let entranceHeader = HeaderView()
    let bedroomHeader = HeaderView()
    
    let interItemSpacing: CGFloat = 32
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        
        collectionViews = [livingRoomCollectionView, kitchenCollectionView, entranceCollectionView, bedroomCollectionView]
        
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
        setupLivingRoomCollectionView()
        setupKitchenCollectionView()
        setupEntranceCollectionView()
        setupBedroomCollectionView()
        anchorBottomCollectionView()
    }
    
    fileprivate func setupLivingRoomCollectionView() {
        livingRoomHeader.label.text = "Sala de estar"
        setupCollectionView(livingRoomCollectionView, withHeader: livingRoomHeader, belowView: scrollView, withTopPadding: 10)
    }
    
    fileprivate func setupKitchenCollectionView() {
        kitchenHeader.label.text = "Cocina"
        setupCollectionView(kitchenCollectionView, withHeader: kitchenHeader, belowView: livingRoomCollectionView, withTopPadding: interItemSpacing)
    }
    
    fileprivate func setupEntranceCollectionView() {
        entranceHeader.label.text = "Entrada"
        setupCollectionView(entranceCollectionView, withHeader: entranceHeader, belowView: kitchenCollectionView, withTopPadding: interItemSpacing)
    }
    
    fileprivate func setupBedroomCollectionView() {
        bedroomHeader.label.text = "Recámara"
        setupCollectionView(bedroomCollectionView, withHeader: bedroomHeader, belowView: entranceCollectionView, withTopPadding: interItemSpacing)
    }
    
    fileprivate func setupCollectionView(_ collectionView: UICollectionView, withHeader header: UIView, belowView bView: UIView, withTopPadding topPadding: CGFloat) {
        
        scrollView.addSubview(header)
        scrollView.addSubview(collectionView)
        
        let topAnchor = (bView == scrollView) ? bView.topAnchor : bView.bottomAnchor
        
        header.anchor(top: topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: topPadding, left: 16, bottom: 0, right: 0), size: CGSize(width: 200, height: 40))
        
        collectionView.anchor(top: header.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor)
        collectionView.anchorSize(size: CGSize(width: view.bounds.width, height: 0))
    }
    
    fileprivate func anchorBottomCollectionView() {
        guard let collectionView = collectionViews.last else { return }
        print(collectionView == bedroomCollectionView)
        collectionView.anchor(top: nil, leading: nil, bottom: scrollView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Dispositivos"
    }
    

    
}
