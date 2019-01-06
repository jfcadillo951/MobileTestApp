//
//  ListViewController.swift
//  MobileTestApp
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

protocol ListViewProtocol {
    func displayHits(hits: [Hit])
    func displayError(message: String)
}

class ListViewController: UIViewController {


    @IBOutlet weak var listTableView: UITableView!
    var presenter: ListPresenter?
    var hits: [Hit] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.getHits()
    }

    func setup() {
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        presenter = ListPresenter(view: self)
    }
}

extension ListViewController: ListViewProtocol {
    func displayHits(hits: [Hit]) {
        self.listTableView.reloadData()
    }
    func displayError(message: String) {

    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hits.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
