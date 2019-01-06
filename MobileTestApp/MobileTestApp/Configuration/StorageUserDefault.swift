//
//  StorageUserDefault.swift
//  MobileTestApp
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

enum StorageKey: String {
    case hitsResponse
    case deletedList
}

protocol StorageProtocol {
    func getHitsResponse() -> Data?
    func saveHitsResponse(data: Data)
    func getDeletedHits() -> Set<String>
    func saveDeletedHit(hitId: String)
}

class StorageUserDefault: StorageProtocol {
    static let sharedInstance = StorageUserDefault()

    func getHitsResponse() -> Data? {
        if let data = UserDefaults.standard.value(forKey: StorageKey.hitsResponse.rawValue) as? Data {
            return data
        }
        return nil
    }

    func saveHitsResponse(data: Data) {
        UserDefaults.standard.set(data, forKey: StorageKey.hitsResponse.rawValue)
    }

    func getDeletedHits() -> Set<String> {
        if let encodedData = UserDefaults.standard.value(forKey: StorageKey.deletedList.rawValue) as? Data {
            if let set = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as? Set<String> {
                return set
            }
        }
        return Set<String>()
    }

    func saveDeletedHit(hitId: String) {
        var set = getDeletedHits()
        if !set.contains(hitId) {
            set.insert(hitId)
            saveDeletedHits(set: set)
        }
    }

    private func saveDeletedHits(set: Set<String>) {
        let encodedData: Data = try! NSKeyedArchiver.archivedData(withRootObject: set, requiringSecureCoding: false)
        UserDefaults.standard.set(encodedData, forKey: StorageKey.deletedList.rawValue)
    }
}
