//
//  ViewController.swift
//  beehybrid
//
//  Created by TATE on 2015. 1. 21..
//  Copyright (c) 2015년 Dayyoung. All rights reserved.
//  Original Source : http://www.kinderas.com/technology/2014/6/15/wkwebview-and-javascript-in-ios-8-using-swift
//

import UIKit
import WebKit

class ViewController: UIViewController , WKScriptMessageHandler ,WKUIDelegate{
    
    @IBOutlet var containerView : UIView! = nil
    
    var webView: WKWebView?
    
    override func loadView() {
        super.loadView()
        
        var contentController = WKUserContentController();
        
        var userScript = WKUserScript(
            source:"AreYouReady()",
            injectionTime: WKUserScriptInjectionTime.AtDocumentEnd,
            forMainFrameOnly: false
        )
        
        contentController.addUserScript(userScript)
        contentController.addScriptMessageHandler(self, name: "beeconJSHandler")
        
        var config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        self.webView = WKWebView(
            frame:self.containerView.bounds,
            configuration: config)
        
        self.view = self.webView
        
        self.webView?.UIDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL(string:"http://beeconjs-dayyoung-1.c9.io/beehybrid.html")
        var req = NSURLRequest(URL: url!)
        self.webView!.loadRequest(req);
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        if(message.name == "beeconJSHandler")
        {
            println("BeeconJS.com : \(message.body)");
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: () -> Void) {
        
        //println("webView:\(webView) runJavaScriptAlertPanelWithMessage:\(message) initiatedByFrame:\(frame) completionHandler:\(completionHandler)")
        let alertController = UIAlertController(title: frame.request.URL.host, message: message, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Default, handler: { action in
            completionHandler()
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
}

