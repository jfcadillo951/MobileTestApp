//
//  DetailViewController.swift
//  MobileTestApp
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var urlString: String?

    convenience init() {
        self.init(nibName: "DetailViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        self.detailWebView.navigationDelegate = self
        let url = URL(string: urlString ?? "")
        self.detailWebView.load(URLRequest(url: url!))
    }

}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.navigationController?.popViewController(animated: true)
    }
}
