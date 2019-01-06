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
    var refreshControl: UIRefreshControl!
    var alertController: UIAlertController?
    var presenter: ListPresenter?
    var hits: [Hit] = []

    convenience init() {
        self.init(nibName: "ListViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.getHits(isFirstTime: true)
    }

    func setup() {
        self.navigationItem.title = StringConstant.APP_NAME
        self.listTableView.register(UINib(nibName: HitTableViewCell.nibName, bundle: nil),
                                    forCellReuseIdentifier: HitTableViewCell.reuseIdentifier)
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(callService), for: .valueChanged)
        self.listTableView.insertSubview(refreshControl, at: 0)
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        presenter = ListPresenter(view: self)
    }

    @objc func callService() {
        presenter?.getHits(isFirstTime: false)
    }
}

extension ListViewController: ListViewProtocol {
    func displayHits(hits: [Hit]) {
        refreshControl.endRefreshing()
        self.hits = hits
        self.listTableView.reloadData()
    }
    func displayError(message: String) {
        refreshControl.endRefreshing()
        alertController = UIAlertController(title: StringConstant.APP_NAME, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (action) in
            self?.alertController?.dismiss(animated: true, completion: nil)
        }
        alertController?.addAction(okAction)
        self.present(alertController!, animated: true) {

        }
    }
    func deleteHit(hits: [Hit], indexPath: IndexPath) {
        refreshControl.endRefreshing()
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

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        var array: [UIContextualAction] = []
        let delete = UIContextualAction(style: .normal, title: StringConstant.CONTENT_LIST_ACTION_DELETE) { (action, view, completed) in
            self.presenter?.deleteHit(indexPath: indexPath)
            completed(true)
        }
        delete.backgroundColor = .red
        array.append(delete)
        return UISwipeActionsConfiguration(actions: array)
    }
}
