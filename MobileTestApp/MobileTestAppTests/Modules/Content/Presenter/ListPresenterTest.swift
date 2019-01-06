//
//  ListPresenterTest.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import XCTest
@testable import MobileTestApp

class ListPresenterTest: XCTestCase {

    var presenter: ListPresenter!
    var view: ListViewSpy!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetsHitsEmptySuccess() {
        // Given
        view = ListViewSpy()
        let repository = ContentRepositoryEmptySuccessSpy()
        presenter = ListPresenter(view: view, repository: repository)
        view.displayErrorExpectation = expectation(description: "testGetsHitsEmptySuccess")
        // When
        presenter.getHits(isFirstTime: false)

        // Then
        wait(for: [view.displayErrorExpectation!], timeout: 10.0)
        XCTAssertTrue(view.displayErrorWasCalled)
        XCTAssertEqual(view.displayErrorMessage, StringConstant.CONTENT_LIST_EMPTY)
    }

    func testGetsHitsSuccess() {
        // Given
        view = ListViewSpy()
        presenter = ListPresenter(view: view, repository: ContentRepositorySuccessSpy())
        view.displayHitsExpectation = expectation(description: "testGetsHitsSuccess")
        // When
        presenter.getHits(isFirstTime: false)

        // Then
        wait(for: [view.displayHitsExpectation!], timeout: 10.0)
        XCTAssertTrue(view.displayHitsWasCalled)
        XCTAssertEqual(view.hits?.count, 1)
    }

    func testGetsHitsError() {
        // Given
        view = ListViewSpy()
        presenter = ListPresenter(view: view, repository: ContentRepositoryErrorSpy())
        view.displayErrorExpectation = expectation(description: "testGetsHitsError")
        // When
        presenter.getHits(isFirstTime: false)

        // Then
        wait(for: [view.displayErrorExpectation!], timeout: 10.0)
        XCTAssertTrue(view.displayErrorWasCalled)
        XCTAssertEqual(view.displayErrorMessage, StringConstant.UNKNOW_ERROR)
    }

}
