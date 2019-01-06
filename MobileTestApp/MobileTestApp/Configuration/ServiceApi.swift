//
//  ServiceApi.swift
//  MobileTestApp
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

protocol ServiceApiProtocol {
    func getHits(success: @escaping ((Data) -> Void), error: @escaping ((NSError?, Int) -> Void))
}
class ServiceApi: ServiceApiProtocol {
    private let hitsUrl = "https://hn.algolia.com/api/v1/search_by_date?query=ios"

    func getHits(success: @escaping ((Data) -> Void), error: @escaping ((NSError?, Int) -> Void)) {
        let url = URL(string: hitsUrl)!
        Alamofire.request(url).responseJSON { (responseJson) in
            switch responseJson.result {
            case .success:
                if let _ = String(data: (responseJson.data)!, encoding: .utf8) {
                    success((responseJson.data)!)
                }
                else {
                    error(nil, 0)
                }
            case .failure:
                error(nil, responseJson.response?.statusCode ?? 0)
            }
        }
    }
}
