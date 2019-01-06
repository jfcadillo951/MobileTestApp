//
//  StorageSpy.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/6/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
@testable import MobileTestApp

class StorageEmptySpy: StorageProtocol {
    func getHitsResponse() -> Data? {
        return nil
    }
    func saveHitsResponse(data: Data) {

    }
    func getDeletedHits() -> Set<String> {
        return Set<String>()
    }
    func saveDeletedHit(hitId: String) {

    }
}

class StorageInMemorySpy: StorageProtocol {
    var hitIdSet: Set<String> = []
    func getHitsResponse() -> Data? {
        return nil
    }
    func saveHitsResponse(data: Data) {

    }
    func getDeletedHits() -> Set<String> {
        return hitIdSet
    }
    func saveDeletedHit(hitId: String) {
        hitIdSet.insert(hitId)
    }
}
