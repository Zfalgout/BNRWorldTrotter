//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Zack Falgout on 5/3/17.
//  Copyright © 2017 Zack Falgout. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, UIWebViewDelegate{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        if let url = URL(string: "https://bignerdranch.com") {
            let request = URLRequest(url: url)
            webView.loadRequest(request)
        }
    }
}
