//
//  AppDelegate.swift
//  SouleCountrol
//
//  Created by Angel Avila on 10/4/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit
import AWSCore
import AWSCognitoIdentityProvider
import AWSS3
//import AWSKinesisVideo

let userPoolID = "us-west-2_vQOuGdjC1"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    static let cellHeight: CGFloat = 120
    
    class func defaultUserPool() -> AWSCognitoIdentityUserPool {
        return AWSCognitoIdentityUserPool(forKey: userPoolID)
    }
    
    var cognitoConfig:CognitoConfig?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let nc = UINavigationController(rootViewController: TabBarController())
        nc.navigationBar.prefersLargeTitles = true
        window?.rootViewController = nc
        window?.makeKeyAndVisible()
        
        AWSDDLog.sharedInstance.logLevel = .verbose
        AWSDDLog.add(AWSDDTTYLogger.sharedInstance)

        cognitoConfig = CognitoConfig()
        setupCognitoUserPool()
        
        return true
    }
    
    func setupCognitoUserPool() {
        let clientId:String = self.cognitoConfig!.getClientId()
        let poolId:String = self.cognitoConfig!.getPoolId()
        let region:AWSRegionType = self.cognitoConfig!.getRegion()
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType:.USWest2,
                                                                identityPoolId:"us-west-2:3d6f7551-7dfd-48dd-bda0-9c0fd63df37f")
        let serviceConfiguration:AWSServiceConfiguration = AWSServiceConfiguration(region: region, credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default()?.defaultServiceConfiguration = serviceConfiguration
        AWSS3.register(with: serviceConfiguration, forKey: "defaultKey")
        //AWSKinesisVideo.register(with: serviceConfiguration, forKey: "defaultKey")
        
        let cognitoConfiguration:AWSCognitoIdentityUserPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: clientId, clientSecret: nil, poolId: poolId)
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: cognitoConfiguration, forKey: userPoolID)
        
        let pool:AWSCognitoIdentityUserPool = AppDelegate.defaultUserPool()
        
        let user = pool.getUser("angel")
        user.getSession("angel", password: "hola12", validationData: nil).continueOnSuccessWith { identitySession -> Any? in
            print("-------------------------")
        }
    }
}
