//
//  ServiceApiSpy.swift
//  MobileTestAppTests
//
//  Created by Nisum on 1/5/19.
//  Copyright © 2019 Demo1. All rights reserved.
//

import UIKit
@testable import MobileTestApp

class ServiceApiSuccessSpy: ServiceApiProtocol {
    func getHits(success: @escaping ((Data) -> Void), error: @escaping ((NSError?, Int) -> Void)) {
        if let path = Bundle.main.path(forResource: "Get_Hits_200", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                success(data)
            } catch {
                // error(nil, 0)
            }
        } else {
            error(nil, 0)
        }
    }
}

class ServiceApiErrorSpy: ServiceApiProtocol {
    func getHits(success: @escaping ((Data) -> Void), error: @escaping ((NSError?, Int) -> Void)) {
        error(nil, 0)
    }
}
