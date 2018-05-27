//
//  WebViewController.swift
//  LovelyAnimals
//
//  Created by Ilya on 5/26/18.
//  Copyright © 2018 Home. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    
    var url: NSURL!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = UIWebView(frame: UIScreen.mainScreen().bounds)
        webView.delegate = self
        view.addSubview(webView)
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
}
