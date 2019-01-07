//
//  DetailViewSpy.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
@testable import MobileTestApp

class DetailViewSpy: DetailViewProtocol {
    var displayDetailWasCalled = false
    var displayDetailUrlRequest: URLRequest?
    func displayDetail(urlRequest: URLRequest) {
        displayDetailWasCalled = true
        displayDetailUrlRequest = urlRequest
    }
}
