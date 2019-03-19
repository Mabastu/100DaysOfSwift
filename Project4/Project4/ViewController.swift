//
//  ViewController.swift
//  Project4
//
//  Created by Mabast on 3/19/19.
//  Copyright © 2019 Mabast. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {
    
    var webView : WKWebView!
    var progressView : UIProgressView!
    var websiteSelected : String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.allowsBackForwardNavigationGestures = true
        // add more space for navifation bar
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let back = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: webView, action: #selector(webView.goBack))
        let forward = UIBarButtonItem(image: UIImage(named: "forward"), style: .plain, target: webView, action: #selector(webView.goForward))
        let refesh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        //
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        //TODO: the array of UIBarButtonItem objects
        toolbarItems = [back, forward, progressButton, spacer, refesh]
        navigationController?.isToolbarHidden = false
        // key-value Observing
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        //TODO: load the website to WebView
        guard let website = websiteSelected else { return }
        let url = URL(string: "https://" + website)!
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let website = websiteSelected else { return }
        
        title = website.dropLast(4).uppercased()
    }
    //TODO: Key-value Observing -  Up to date loading progress
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    //TODO:
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        guard let website = websiteSelected else { return }
        if let host = url?.host {
            if host.contains(website) {
                decisionHandler(.allow)
                return
            }
        }
        decisionHandler(.cancel)
        let alert = UIAlertController(title: "URL is blocked", message: "This website is not allow visiting", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        present(alert, animated: true)
    }
}




