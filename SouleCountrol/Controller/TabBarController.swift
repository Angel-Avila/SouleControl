//
//  TabBarController.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit
import AWSCore
import AWSS3

class TabBarController: UITabBarController {

    static var people = [Person]()
    static var bulbs = [Bulb]()
    static var cams = [Cam]()
    static var doors = [Door]()
    static var arrivalHours = [ArrivalHour]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let devicesVC = DevicesVC(screenWidth: view.bounds.width)
        devicesVC.tabBarItem = UITabBarItem(title: "Dispositivos", image: #imageLiteral(resourceName: "home"), tag: 0)
        
        let analyticsVC = AnalyticsVC(screenWidth: view.bounds.width)
        analyticsVC.tabBarItem = UITabBarItem(title: "Dashboard", image: #imageLiteral(resourceName: "dashboard"), tag: 1)
        
        let securityVC = SecurityVC()
        securityVC.tabBarItem = UITabBarItem(title: "Seguridad", image: #imageLiteral(resourceName: "security"), tag: 2)
        
        let tabList = [devicesVC, analyticsVC, securityVC]
        
        viewControllers = tabList
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
            self.downloadPeopleNamesFromBucket()
        }
        
        downloadAllArraysFromServer()
    }
    
    fileprivate func downloadAllArraysFromServer() {
        downloadCamsInfo()
        downloadBulbsInfo()
        downloadDoorsInfo()
        downloadArrivalHoursInfo()
    }
    
    fileprivate func downloadPeopleNamesFromBucket() {
        let bucket = "facesiot"
        
        let s3 = AWSS3.s3(forKey: "defaultKey")
        
        let listRequest: AWSS3ListObjectsRequest = AWSS3ListObjectsRequest()
        listRequest.bucket = bucket
        
        s3.listObjects(listRequest).continueWith { (task) -> AnyObject? in
            
            for object in (task.result?.contents)! {
                self.downloadImage(fromBucket: bucket, fileName: object.key)
            }
            
            return nil
        }
    }
    
    fileprivate func downloadImage(fromBucket bucket: String, fileName: String?) {
        
        guard let fileName = fileName else { return }
        
        let transferManager = AWSS3TransferManager.default()
        
        let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("temp.jpg")
        
        if let downloadRequest = AWSS3TransferManagerDownloadRequest(){
            downloadRequest.bucket = bucket
            downloadRequest.key = fileName
            downloadRequest.downloadingFileURL = downloadingFileURL
            
            transferManager.download(downloadRequest).continueWith(executor: AWSExecutor.default(), block: { (task: AWSTask<AnyObject>) -> Any? in
                if( task.error != nil){
                    print(task.error!.localizedDescription)
                    return nil
                }
                
                print(task.result!)
                
                if let data = NSData(contentsOf: downloadingFileURL){
                    DispatchQueue.main.async(execute: { () -> Void in
                        if let img = UIImage(data: data as Data) {
                            let name = fileName.components(separatedBy: ".").first!
                            TabBarController.people.append(Person(name: name, image: img))
                            self.downloadArrivalHoursInfo()
                        } else {
                            print("There was no image :(")
                        }
                    })
                }
                return nil
            })
        }
    }
    
    fileprivate func downloadArrivalHoursInfo() {
        Database.instance.getAllArrivalHours { hours in
            guard let hours = hours else { return }
            TabBarController.arrivalHours = hours
        }
    }
    
    fileprivate func downloadBulbsInfo() {
        Database.instance.getAllBulbs { bulbs in
            guard let bulbs = bulbs else { return }
            TabBarController.bulbs = bulbs
        }
    }
    
    fileprivate func downloadCamsInfo() {
        Database.instance.getAllCams { cams in
            guard let cams = cams else { return }
            TabBarController.cams = cams
        }
    }
    
    fileprivate func downloadDoorsInfo() {
        Database.instance.getAllDoors { doors in
            guard let doors = doors else { return }
            TabBarController.doors = doors
        }
    }
}


