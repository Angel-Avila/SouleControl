//
//  LoginViewController.swift
//  SouleCountrol
//
//  Created by Angel Avila on 11/5/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class LoginViewController: UIViewController {

    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    
    override func viewDidLoad() {
        view.backgroundColor = .red
    }

}

extension LoginViewController: AWSCognitoIdentityPasswordAuthentication {
    
    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
    }
    
    public func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}
