//
//  DetailPresenter.swift
//  MobileTestApp
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

protocol DetailPresenterProtocol {
    func load()
}
class DetailPresenter: DetailPresenterProtocol {
    let view: DetailViewProtocol

    init(view: DetailViewProtocol) {
        self.view = view
    }

    func load() {
        self.view.displayDetail()
    }
}
