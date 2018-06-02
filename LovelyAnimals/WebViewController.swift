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
        self.webView.scalesPageToFit = true
        self.webView.contentMode = .ScaleAspectFit
        view.addSubview(webView)
        
        webView.loadRequest(NSURLRequest(URL: url))
    }
    
    /*func webViewDidFinishLoad(webView: UIWebView) {
        self.webView.scrollView.minimumZoomScale = 1.0
        self.webView.scrollView.maximumZoomScale = 5.0
        self.webView.stringByEvaluatingJavaScriptFromString("document.querySelector('meta[name=viewport]').setAttribute('content', 'user-scalable = 1;', false); ")
    }*/

}
