//
//  DetailPresenterTest.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import XCTest
@testable import MobileTestApp

class DetailPresenterTest: XCTestCase {

    var view: DetailViewSpy!
    var presenter: DetailPresenter!
    override func setUp() {
        view = DetailViewSpy()
        presenter = DetailPresenter(view: view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoad() {
        // Given

        // When
        presenter.load(urlString: "http://www.google.com")

        // Then
        XCTAssertTrue(view.displayDetailWasCalled)
    }
}
