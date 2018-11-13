//
//  Database.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/22/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit
import Alamofire

enum DatabaseType: String {
    case Bulb = "/bulb/"
    case ArrivalHour = "/arrivalHour/"
    case Cam = "/cam/"
    case Door = "/door/"
}

public class Database {
    
    // MARK: - Vars and private init
    
    /// Singleton instance to call all the functions with
    public class var instance: Database {
        struct Singleton {
            static let instance = Database()
        }
        return Singleton.instance
    }
    
    private init() {}
    
    private var BASE_URL = "http://ec2-54-149-173-24.us-west-2.compute.amazonaws.com:8081/api"
    
    func getAllBulbs(completion: ((_ bulbs: [Bulb]?) -> Void)?) {
        getAll(object: Bulb(), completion: completion)
    }
    
    func getAllArrivalHours(completion: ((_ arrivalHours: [ArrivalHour]?) -> Void)?) {
        getAll(object: ArrivalHour(), completion: completion)
    }
    
    func getAllCams(completion: ((_ cams: [Cam]?) -> Void)?) {
        getAll(object: Cam(), completion: completion)
    }
    
    func getAllDoors(completion: ((_ doors: [Door]?) -> Void)?) {
        getAll(object: Door(), completion: completion)
    }
    
    fileprivate func getAll<T: Decodable>(object: T, completion: ((_ things: [T]?) -> Void)?) {
        
        let url = URL(string: getUrlStr(from: object))!
        
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode,
                statusCode == 200,
                let data = response.data
                else {
                completion?(nil)
                return
            }
            
            do {
                let things = try JSONDecoder().decode([T].self, from: data)
                completion?(things)
            } catch let jsonErr {
                print("Error: ", jsonErr)
            }
        }
    }
    
    func turn(_ cam: Cam, on: Bool, completion: ((Bool) -> Void)?) {
        let parameters: Parameters = ["minutesOn": cam.minutesOn ?? 0,
                                      "isOn": on,
                                      "name": cam.name]
        
        update(cam, parameters: parameters, completion: completion)
    }
    
    fileprivate func update(_ object: Device, parameters: [String: Any], completion: ((Bool) -> Void)?) {
        
        let url = URL(string: getUrlStr(from: object) + object._id)!
        
        Alamofire.request(url, method: .put, parameters: parameters, encoding: JSONEncoding.default).responseJSON { response in
            
            if response.data != nil {
                completion?(true)
                return
            }
            
            completion?(false)
        }
    }
    
    fileprivate func getUrlStr<T>(from object: T) -> String {
        let typeStr: String!
        
        if object is Bulb {
            typeStr = DatabaseType.Bulb.rawValue
        } else if object is ArrivalHour {
            typeStr = DatabaseType.ArrivalHour.rawValue
        } else if object is Cam {
            typeStr = DatabaseType.Cam.rawValue
        } else if object is Door {
            typeStr = DatabaseType.Door.rawValue
        } else {
            typeStr = ""
        }
        
        return  BASE_URL + typeStr
    }
}
