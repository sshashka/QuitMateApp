//
//  TermsAndConditionsView.swift
//  StopMate
//
//  Created by Саша Василенко on 18.08.2023.
//

import UIKit
import WebKit

class TermsAndConditionsView: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    var selectedURL: String?
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let selectedURL else { return }
        let myURL = URL(string: selectedURL)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
