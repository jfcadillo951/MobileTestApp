//
//  ContentRepositorySpy.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
@testable import MobileTestApp

class ContentRepositorySuccessSpy: ContentRepositoryProtocol {
    func getHits(onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void)) {
        let hit = Hit(JSON: ["objectID" : "1234",
                             "story_title": "test",
                             "author": "author test",
                             "created_at": "2019-01-05T19:40:31.000Z"])
        let hitsReponse = HitsResponse()
        hitsReponse.hits = [hit!]
        onSuccess(hitsReponse)
    }
}

class ContentRepositoryErrorSpy: ContentRepositoryProtocol {
    func getHits(onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void)) {
        onError(StringConstant.UNKNOW_ERROR)
    }
}
