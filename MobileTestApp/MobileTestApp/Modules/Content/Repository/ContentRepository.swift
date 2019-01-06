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
}

class ContentRepository: ContentRepositoryProtocol {
    let serviceApi: ServiceApiProtocol
    
    init(serviceApi: ServiceApiProtocol) {
        self.serviceApi = serviceApi
    }

    func getHits(onSuccess: @escaping ((HitsResponse) -> Void), onError: @escaping ((String) -> Void)) {
        serviceApi.getHits(success: { (json) in
            if let hitsResponse = HitsResponse(JSON: json) {
                onSuccess(hitsResponse)
            } else {
                onError(StringConstant.UNKNOW_ERROR)
            }
        }) { (errorValue, statusCode) in
            onError(StringConstant.UNKNOW_ERROR)
        }
    }
}
