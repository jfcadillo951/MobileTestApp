//
//  ListViewSpy.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
@testable import MobileTestApp

class ListViewSpy: ListViewProtocol {

    var displayHitsWasCalled = false
    var hits: [Hit]?
    func displayHits(hits: [Hit]) {
        displayHitsWasCalled = true
        self.hits = hits
    }

    var displayErrorWasCalled = false
    var displayErrorMessage = ""
    func displayError(message: String) {
        displayErrorWasCalled = true
        displayErrorMessage = message
    }

    func deleteHit(hits: [Hit], indexPath: IndexPath) {

    }
}
