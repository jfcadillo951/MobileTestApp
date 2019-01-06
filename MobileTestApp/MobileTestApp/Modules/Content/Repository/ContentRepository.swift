//
//  ContentRepository.swift
//  MobileTestApp
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit

protocol ContentRepositoryProtocol {
    func getHits(onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void))
    func getDeletedHits(deletedHits: @escaping ((Set<String>) -> Void))
    func saveDeletedHit(hitId: String)
}

class ContentRepository: ContentRepositoryProtocol {
    let serviceApi: ServiceApiProtocol
    let storage: StorageProtocol

    init(serviceApi: ServiceApiProtocol, storage: StorageProtocol = StorageUserDefault()) {
        self.serviceApi = serviceApi
        self.storage = storage
    }

    func getHits(onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void)) {
        if let savedData = self.storage.getHitsResponse(),
            let string = String(data: savedData, encoding: String.Encoding.utf8),
            let hitsResponse = HitsResponse(JSONString: string) {
            onSuccess(hitsResponse)
        }
        serviceApi.getHits(success: { [weak self] (data) in
            if let string = String(data: data, encoding: String.Encoding.utf8),
                let hitsResponse = HitsResponse(JSONString: string) {
                self?.storage.saveHitsResponse(data: data)
                onSuccess(hitsResponse)
            }
            else {
                onError(StringConstant.UNKNOW_ERROR)
            }
        }) { (errorValue, statusCode) in
            onError(StringConstant.UNKNOW_ERROR)
        }
    }

    func getDeletedHits(deletedHits: @escaping ((Set<String>) -> Void)) {
        deletedHits(self.storage.getDeletedHits())
    }

    func saveDeletedHit(hitId: String) {
        self.storage.saveDeletedHit(hitId: hitId)
    }
}
