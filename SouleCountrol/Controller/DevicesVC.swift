//
//  DevicesVC.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class DevicesVC: GenericCollectionViewController<DeviceCell, Device>, UIGestureRecognizerDelegate {

    var devices: [[Device]] = [[Device(name: "Foco 1", type: .light, isOn: true),
                    Device(name: "Foco 2", type: .light)
                    ],
                   
                   [Device(name: "Foco", type: .light),
                    Device(name: "Termómetro", type: .extra, isOn: true)
                    ],
                   
                   [],
                   
                   [Device(name: "Puerta del cuarto", type: .door, isOn: true),
                    Device(name: "Foco", type: .light)]]
    
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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1100)) {
            self.setupLivingRoomFromServer()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Dispositivos"
        setupLivingRoomFromServer()
    }
    
    fileprivate func setupLivingRoomFromServer() {
        var devs = [Device]()
        devs.append(contentsOf: TabBarController.cams)
        devs.append(contentsOf: TabBarController.bulbs)
        devs.append(contentsOf: TabBarController.doors)
        
        devices[2] = devs
        items = devices
        
        entranceCollectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! DeviceCell
        
        let device = items[collectionView.tag][indexPath.row]
        device.isOn = !device.isOn
        
        cell.item = device
        cell.updateUI()
        
        collectionView.reloadItems(at: [indexPath])
        
        if collectionView != entranceCollectionView {
            return
        }
        
        if device is Cam {
            Database.instance.turn(device as! Cam, on: device.isOn) { success in
                print("Success:", success)
            }
        }
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
        collectionView.anchor(top: nil, leading: nil, bottom: scrollView.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
    }
}
