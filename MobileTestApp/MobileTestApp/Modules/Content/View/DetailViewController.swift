//
//  DetailViewController.swift
//  MobileTestApp
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
import WebKit

protocol DetailViewProtocol {
    func displayDetail(urlRequest: URLRequest)
}

class DetailViewController: UIViewController {

    @IBOutlet weak var detailWebView: WKWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var presenter: DetailPresenterProtocol?
    var urlString: String?

    convenience init() {
        self.init(nibName: "DetailViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        presenter = DetailPresenter(view: self)
        self.activityIndicator.isHidden = false
        self.detailWebView.navigationDelegate = self
        presenter?.load(urlString: urlString ?? "")
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

extension DetailViewController: DetailViewProtocol {
    func displayDetail(urlRequest: URLRequest) {
        self.activityIndicator.startAnimating()
        self.detailWebView.load(urlRequest)
    }
}
