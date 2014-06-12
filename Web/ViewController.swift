//
//  ViewController.swift
//  Web
//
//  Created by David Cabrera on 6/12/14.
//  Copyright (c) 2014 David Cabrera. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIWebViewDelegate {
    @IBOutlet var webView : UIWebView = nil
                            
    override func viewDidLoad() {
        
        // When the webview loads, the web view object is asked to show the default homepage
        let url:NSURL = NSURL(string: "http://www.cnn.com")
        let urlRequest: NSURLRequest = NSURLRequest(URL: url)
        self.webView.loadRequest(urlRequest)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
    UITextFieldDelegate method
    Called when user taps the "Go" on the keyboard.
    Check to see if "http://" is present.
    */
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        
        // relinquish first responder status
        textField.resignFirstResponder()
        
        var urlText: String = textField.text
        
        var prefix: String = "http://"
        
        if urlText.hasPrefix(prefix) {
          
            let url: NSURL = NSURL(string: urlText)
            let urlRequest: NSURLRequest = NSURLRequest(URL: url)
            self.webView.loadRequest(urlRequest)
        }
        else {
            var updatedURL = prefix + urlText
            let url: NSURL = NSURL(string: updatedURL)
            let urlRequest: NSURLRequest = NSURLRequest(URL: url)
            self.webView.loadRequest(urlRequest)
            textField.text = updatedURL
        }
        
        return true
    }
    
    // UIWebViewDelegate methods
    func webViewDidStartLoad(webView: UIWebView!) {
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func webViewDidFinishLoad(webView: UIWebView!) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    func webView(webView: UIWebView!, didFailLoadWithError error: NSError!) {
        var errorString: String = "<html><font size=+2 color='red'><p>An error occurred: \(error.localizedDescription)<br />Possible causes for this error:<br />- No network connection<br />- Wrong URL entered<br />- Server computer is down</p></font></html>"
        
        self.webView.loadHTMLString(errorString, baseURL: nil)
    }
}

