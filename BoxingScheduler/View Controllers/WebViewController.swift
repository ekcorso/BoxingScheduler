//
//  WebViewController.swift
//  BoxingScheduler
//
//  Created by Emily Corso on 1/1/22.
//

import Foundation
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://app.squarespacescheduling.com/schedule.php?owner=19967298&template=class&PHPSESSID=gmeh4tdhpomua2io58bikmg6sc")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
}
