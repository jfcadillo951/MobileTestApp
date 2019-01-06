//
//  ListViewSpy.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
import XCTest
@testable import MobileTestApp

class ListViewSpy: ListViewProtocol {

    var displayHitsWasCalled = false
    var hits: [Hit]?
    var displayHitsExpectation: XCTestExpectation?
    func displayHits(hits: [Hit]) {
        displayHitsWasCalled = true
        self.hits = hits
        displayHitsExpectation?.fulfill()
    }

    var displayErrorWasCalled = false
    var displayErrorMessage = ""
    var displayErrorExpectation: XCTestExpectation?
    func displayError(message: String) {
        displayErrorWasCalled = true
        displayErrorMessage = message
        displayErrorExpectation?.fulfill()
    }

    func deleteHit(hits: [Hit], indexPath: IndexPath) {

    }
}
