//
//  CameraVC.swift
//  SouleCountrol
//
//  Created by Angel Avila on 11/20/18.
//  Copyright © 2018 Angel Avila. All rights reserved.
//

import UIKit
import WebKit
//import AWSKinesisVideo
//import AWSKinesisVideoArchivedMedia

class CameraVC: UIViewController, WKUIDelegate {

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let streamName = "LiveRekognitonVideoAnalysisBlog"
        
        let kinesisVideo = AWSKinesisVideo.default()
        
        let kinesisVideoArchivedContent = AWSKinesisVideoArchivedMedia(forKey: streamName)
        
        do {
            let input = try AWSKinesisVideoGetDataEndpointInput(dictionary: ["StreamName": streamName], error: ())
            input.apiName = .getHlsStreamingSessionUrl
            
            kinesisVideo.getDataEndpoint(input) { (output, error) in
                print("Dataendpoint:", output?.dataEndpoint ?? "nil dataendpoint")
            }
        } catch let error {
            print(error.localizedDescription)
        }*/
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Cámara"
        loadWebView()
    }
    
    fileprivate func loadWebView() {
        let myURL = Bundle.main.url(forResource: "index", withExtension: "html")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
