//
//  ListPresenter.swift
//  MobileTestApp
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

protocol ListPresenterProtocol {
    func getHits(isFirstTime: Bool)
    func deleteHit(indexPath: IndexPath)
}
class ListPresenter: ListPresenterProtocol {

    let view: ListViewProtocol
    let repository: ContentRepositoryProtocol
    var hits: [Hit] = []

    init(view: ListViewProtocol,
         repository: ContentRepositoryProtocol = ContentRepository(serviceApi: ServiceApi())) {
        self.view = view
        self.repository = repository
    }

    func getHits(isFirstTime: Bool) {
        self.repository.getHits(isFirstTime: isFirstTime, onSuccess: { [weak self] (hitsResponse) in
            self?.repository.getDeletedHits(deletedHits: { [weak self] (set) in
                self?.hits = []
                let filterHits = hitsResponse.hits?.filter({ (filterHit) -> Bool in
                    return !set.contains(filterHit.objectID ?? "")
                })
                if let hits = filterHits, !hits.isEmpty {
                    self?.hits = hits
                    DispatchQueue.main.async {
                        self?.view.displayHits(hits: hits)
                    }

                } else {
                    DispatchQueue.main.async {
                        self?.view.displayError(message: StringConstant.CONTENT_LIST_EMPTY)
                    }
                }
            })

        }) { [weak self] (errorString) in
            DispatchQueue.main.async {
                self?.view.displayError(message: errorString)
            }
        }
    }

    func deleteHit(indexPath: IndexPath) {
        let hit = hits[indexPath.row]
        self.repository.saveDeletedHit(hitId: hit.objectID!)
        self.repository.getDeletedHits(deletedHits: { [weak self] (set) in
            let filterHits = self?.hits.filter({ (filterHit) -> Bool in
                return !set.contains(filterHit.objectID ?? "")
            })
            self?.hits = filterHits!
            DispatchQueue.main.async {
                self?.view.deleteHit(hits: filterHits!, indexPath: indexPath)
            }
        })
    }
}
