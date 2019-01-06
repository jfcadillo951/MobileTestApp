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
    func deleteHit(hits: [Hit], indexPath: IndexPath)
}

class ListViewController: UIViewController {
    @IBOutlet weak var listTableView: UITableView!
    var alertController: UIAlertController?
    var presenter: ListPresenter?
    var hits: [Hit] = []

    convenience init() {
        self.init(nibName: "ListViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.getHits()
    }

    func setup() {
        self.listTableView.register(UINib(nibName: HitTableViewCell.nibName, bundle: nil),
                                    forCellReuseIdentifier: HitTableViewCell.reuseIdentifier)
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        presenter = ListPresenter(view: self)
    }
}

extension ListViewController: ListViewProtocol {
    func displayHits(hits: [Hit]) {
        self.hits = hits
        self.listTableView.reloadData()
    }
    func displayError(message: String) {
        alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (action) in
            self?.alertController?.dismiss(animated: true, completion: nil)
        }
        alertController?.addAction(okAction)
        self.present(alertController!, animated: true) {

        }
    }
    func deleteHit(hits: [Hit], indexPath: IndexPath) {
        self.hits = hits
        self.listTableView.deleteRows(at: [indexPath], with: .automatic)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: HitTableViewCell.reuseIdentifier, for: indexPath) as? HitTableViewCell {
            cell.setup(data: self.hits[indexPath.row])
            return cell
        }
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
        return 40.0
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
