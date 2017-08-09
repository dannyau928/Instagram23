//
//  UserAuthWebViewController.swift
//  Instagram23
//
//  Created by Danny Au on 7/26/17.
//  Copyright © 2017 DannyAu. All rights reserved.
//

import UIKit

class UserAuthWebViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var urlRequest: URLRequest?
    var callback: ((_ accessToken: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
        if let urlRequest = urlRequest {
            webView.loadRequest(urlRequest)
        }
    }
    
    @IBAction func closeClicked(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - UIWebViewDelegate
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        #if DEBUG
            print("UserAuthWebViewController.shouldStartLoadWithRequest(), request=\(request)")
        #endif
        
        if let urlString = request.url?.absoluteString {
            let splitUrl = urlString.components(separatedBy: "#\(KEY_ACCESS_TOKEN)=")
            if splitUrl.count > 1 {
                let accessToken = splitUrl[splitUrl.count - 1]
                callback?(accessToken)
                dismiss(animated: true, completion: nil)
                return false
            }
        }

        return true
    }
}
