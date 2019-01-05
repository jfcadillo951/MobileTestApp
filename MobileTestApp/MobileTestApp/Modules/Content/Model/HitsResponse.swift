//
//  HitsResponse.swift
//  MobileTestApp
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
import ObjectMapper

class HitsResponse: Mappable {
    var hits: [Hit]?
    var nbHits: Int?
    var page: Int?
    var nbPages: Int?
    var hitsPerPage: Int?
    var processingTimeMS: Int?
    var exhaustiveNbHits: Bool?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        hits                <-      map["hits"]
        nbHits              <-      map["nbHits"]
        page                <-      map["page"]
        hitsPerPage         <-      map["hitsPerPage"]
        processingTimeMS    <-      map["processingTimeMS"]
        exhaustiveNbHits    <-      map["exhaustiveNbHits"]
    }
}
