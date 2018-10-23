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
    case Bulb = "/bulb"
    case ArrivalHour = "/arrivalHour"
    case Cam = "/cam"
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
    
    fileprivate func getAll<T: Decodable>(object: T, completion: ((_ things: [T]?) -> Void)?) {
        let typeStr: String!
        
        if object is Bulb {
            typeStr = DatabaseType.Bulb.rawValue
        } else if object is ArrivalHour {
            typeStr = DatabaseType.ArrivalHour.rawValue
        } else if object is Cam {
            typeStr = DatabaseType.Cam.rawValue
        } else {
            typeStr = ""
        }
        
        let url = URL(string: BASE_URL + typeStr)!
        
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
}
