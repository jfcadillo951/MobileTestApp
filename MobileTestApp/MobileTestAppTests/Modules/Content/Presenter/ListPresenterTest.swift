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

    func testDeleteHit() {
        // Given
        view = ListViewSpy()
        let repository = ContentRepositorySuccessSpy()
        presenter = ListPresenter(view: view, repository: repository)
        presenter.getHits(isFirstTime: false)
        view.deleteHitExpectation = expectation(description: "testDeleteHit")
        let indexPath = IndexPath(row: 0, section: 0)

        // When
        presenter.deleteHit(indexPath: indexPath)

        // Then
        wait(for: [view.deleteHitExpectation!], timeout: 10.0)
        XCTAssertTrue(view.deleteHitWasCalled)
        XCTAssertEqual(view.deleteHits?.count, 0)
        XCTAssertEqual(view.deleteHitIndexPath, indexPath)
    }

    func testSelectHitSuccess() {
        // Given
        view = ListViewSpy()
        let repository = ContentRepositorySuccessSpy()
        presenter = ListPresenter(view: view, repository: repository)
        presenter.getHits(isFirstTime: false)

        // When
        presenter.selectHit(indexPath: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertTrue(view.displayHitDetailWasCalled)
        XCTAssertEqual(view.displayHitDetail?.objectID, presenter.hits.first?.objectID)
    }

    func testSelectHitNoURLError() {
        // Given
        view = ListViewSpy()
        let repository = ContentRepositorySuccessSpyWrongURL()
        presenter = ListPresenter(view: view, repository: repository)
        presenter.getHits(isFirstTime: false)

        // When
        presenter.selectHit(indexPath: IndexPath(row: 0, section: 0))

        // Then
        XCTAssertTrue(view.displayErrorWasCalled)
        XCTAssertEqual(view.displayErrorMessage, StringConstant.CONTENT_LIST_HIT_NO_URL)
    }
}
