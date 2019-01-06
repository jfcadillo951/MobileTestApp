//
//  ListPresenter.swift
//  MobileTestApp
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

protocol ListPresenterProtocol {
    func getHits()
}
class ListPresenter: ListPresenterProtocol {

    let view: ListViewProtocol
    let repository: ContentRepositoryProtocol

    init(view: ListViewProtocol,
         repository: ContentRepositoryProtocol = ContentRepository(serviceApi: ServiceApi())) {
        self.view = view
        self.repository = repository
    }

    func getHits() {
        self.repository.getHits(onSuccess: { [weak self] (hitsResponse) in
            if let hits = hitsResponse.hits, !hits.isEmpty {
                self?.view.displayHits(hits: hits)
            } else {
                self?.view.displayError(message: StringConstant.CONTENT_LIST_EMPTY)
            }

        }) { [weak self] (errorString) in
            self?.view.displayError(message: errorString)
        }
    }
}
