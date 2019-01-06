//
//  ContentRespositoryTest.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import XCTest
@testable import MobileTestApp

class ContentRespositoryTest: XCTestCase {

    var repository: ContentRepository!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGetHitsSuccess() {
        // Given
        repository = ContentRepository(serviceApi: ServiceApiSuccessSpy())
        //When
        repository.getHits(onSuccess: { (hitsResponse) in
            // then
            XCTAssertEqual(hitsResponse.hits?.count, 2)
            XCTAssertEqual(hitsResponse.hits?.first?.objectID, "18833731")
            XCTAssertEqual(hitsResponse.hits?.first?.title, "HelenOS 0.8.0 Released")
            XCTAssertEqual(hitsResponse.hits?.first?.author, "yjftsjthsd-h")
            XCTAssertEqual(hitsResponse.hits?.first?.created_at, "2019-01-05T19:40:31.000Z")
        }) { (errorString) in

        }
    }

    func testGetHitsGenericError() {
        // Given
        repository = ContentRepository(serviceApi: ServiceApiErrorSpy())
        //When
        repository.getHits(onSuccess: { (hitsResponse) in

        }) { (errorString) in
            // then
            XCTAssertEqual(errorString, StringConstant.UNKNOW_ERROR)
        }
    }

}
