//
//  Hit.swift
//  MobileTestApp
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
import ObjectMapper

class Hit: Mappable {

    var objectID: String?
    var title: String?
    var author: String?
    var created_at: String?

    required init?(map: Map) {
    }

    func mapping(map: Map) {
        objectID    <-      map["objectID"]
        title       <-      map["story_title"]
        author      <-      map["author"]
        created_at  <-      map["created_at"]
    }
}
