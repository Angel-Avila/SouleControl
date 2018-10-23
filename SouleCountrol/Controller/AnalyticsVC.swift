//
//  AnalyticsVC.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit

class AnalyticsVC: GenericCollectionViewController<DeviceCell, Device>, UIGestureRecognizerDelegate {
    
    let devices = [[Device(name: "Foco 1", type: .light, isOn: true),
                    Device(name: "Foco 2", type: .light)
                   ]]
    
    let scrollView = ScrollView()
    
    let bulbsHeader = HeaderView()
    let camsHeader = HeaderView()
    let arrivalHoursHeader = HeaderView()
    
    fileprivate let detailColor = UIColor(white: 0.6, alpha: 1)
    
    lazy var bulbMinutesOnLabel: UILabel! = {
        let label = Label(labelText: "Minutos encendidos: -", size: 20, textColor: detailColor)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    
    lazy var camMinutesOnLabel: UILabel! = {
        let label = Label(labelText: "Minutos encendida: -", size: 20, textColor: detailColor)
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    let arrivalHoursCollectionView = CollectionView()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        collectionViews = [arrivalHoursCollectionView]
        items = devices
        
        super.viewDidLoad()
        
        setupViews()
        
        Database.instance.getAllArrivalHours { hours in
            guard let hours = hours else { print("no rifa"); return }
            print("Arrival Hours -------------------")
            for hour in hours {
                print(hour.person ?? "nil")
                print(hour.hour ?? "nil")
            }
        }
        
        Database.instance.getAllCams { cams in
            guard let cams = cams else { return }
            
            let minutes = cams.map { $0.minutesOn ?? 0 }
            let sum = minutes.reduce(0, +)
            self.camMinutesOnLabel.text = "Minutos encendida: " + String(sum)
        }
        
        Database.instance.getAllBulbs { bulbs in
            guard let bulbs = bulbs else { return }
            
            let minutes = bulbs.map { $0.minutesOn ?? 0 }
            let sum = minutes.reduce(0, +)
            self.bulbMinutesOnLabel.text = "Minutos encendidos: " + String(sum)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Dashboard"
    }
    
    fileprivate func setupViews() {
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        setupBulbsDashboard()
        setupCamDashboard()
        setupArrivalHoursDashboard()
    }
    
    fileprivate func setupBulbsDashboard() {
        bulbsHeader.label.text = "Focos"
        
        scrollView.addSubview(bulbsHeader)
        scrollView.addSubview(bulbMinutesOnLabel)
        
        let xInset: CGFloat = 16
        
        bulbsHeader.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: xInset, bottom: 0, right: 0), size: CGSize(width: 200, height: 40))
        bulbMinutesOnLabel.anchor(top: bulbsHeader.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: xInset + 4, bottom: 0, right: xInset))
    }
    
    fileprivate func setupCamDashboard() {
        camsHeader.label.text = "Cámaras"
        
        scrollView.addSubview(camsHeader)
        scrollView.addSubview(camMinutesOnLabel)
        
        let xInset: CGFloat = 16
        
        camsHeader.anchor(top: bulbMinutesOnLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 32, left: xInset, bottom: 0, right: 0), size: CGSize(width: 200, height: 40))
        camMinutesOnLabel.anchor(top: camsHeader.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: xInset + 4, bottom: 0, right: xInset))
    }
    
    fileprivate func setupArrivalHoursDashboard() {
        arrivalHoursHeader.label.text = "Horas de llegada"
        
        scrollView.addSubview(arrivalHoursHeader)
        scrollView.addSubview(arrivalHoursCollectionView)
        
        let xInset: CGFloat = 16
        
        arrivalHoursHeader.anchor(top: camMinutesOnLabel.bottomAnchor, leading: scrollView.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 32, left: xInset, bottom: 0, right: 0), size: CGSize(width: 200, height: 40))
        
        arrivalHoursCollectionView.anchor(top: arrivalHoursHeader.bottomAnchor, leading: scrollView.leadingAnchor, bottom: scrollView.bottomAnchor, trailing: scrollView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0))
        arrivalHoursCollectionView.anchorSize(size: CGSize(width: view.bounds.width, height: 0))
    }
}
