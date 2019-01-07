//
//  ContentRepositorySpy.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
@testable import MobileTestApp

class ContentRepositoryEmptySuccessSpy: ContentRepositoryProtocol {
    func getHits(isFirstTime: Bool, onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void)) {
        let hitsReponse = HitsResponse()
        onSuccess(hitsReponse)
    }

    func saveDeletedHit(hitId: String) {

    }

    func getDeletedHits(deletedHits: @escaping ((Set<String>) -> Void)) {
        deletedHits([])
    }
}

class ContentRepositorySuccessSpy: ContentRepositoryProtocol {
    var deletedHitsSet: Set<String> = []

    func getHits(isFirstTime: Bool, onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void)) {
        let hit = Hit(JSON: ["objectID" : "1234",
                             "story_title": "test",
                             "author": "author test",
                             "created_at": "2019-01-05T19:40:31.000Z",
                             "story_url": "http://www.google.com"])
        let hitsReponse = HitsResponse()
        hitsReponse.hits = [hit!]
        onSuccess(hitsReponse)
    }

    func saveDeletedHit(hitId: String) {
        deletedHitsSet.insert(hitId)
    }

    func getDeletedHits(deletedHits: @escaping ((Set<String>) -> Void)) {
        deletedHits(deletedHitsSet)
    }
}

class ContentRepositorySuccessSpyWrongURL: ContentRepositoryProtocol {
    var deletedHitsSet: Set<String> = []

    func getHits(isFirstTime: Bool, onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void)) {
        let hit = Hit(JSON: ["objectID" : "1234",
                             "story_title": "test",
                             "author": "author test",
                             "created_at": "2019-01-05T19:40:31.000Z",
                             "story_url": "a b c d e f"])
        let hitsReponse = HitsResponse()
        hitsReponse.hits = [hit!]
        onSuccess(hitsReponse)
    }

    func saveDeletedHit(hitId: String) {
        deletedHitsSet.insert(hitId)
    }

    func getDeletedHits(deletedHits: @escaping ((Set<String>) -> Void)) {
        deletedHits(deletedHitsSet)
    }
}

class ContentRepositoryErrorSpy: ContentRepositoryProtocol {
    func getHits(isFirstTime: Bool, onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void)) {
        onError(StringConstant.UNKNOW_ERROR)
    }

    func saveDeletedHit(hitId: String) {

    }

    func getDeletedHits(deletedHits: @escaping ((Set<String>) -> Void)) {
        deletedHits([])
    }
}
