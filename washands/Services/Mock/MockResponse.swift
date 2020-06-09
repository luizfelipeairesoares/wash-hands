//
//  MockResponse.swift
//  washandsTests
//
//  Created by Luiz Felipe Aires Soares on 08/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

public class MockResponse {
    
    public init() { }
    
    public func data(json: String) -> Data {
        let resource = Bundle.main.url(forResource: json, withExtension: "json")!
        do {
            let data = try Data(contentsOf: resource)
            return data
        } catch {
            return Data()
        }
    }
    
}
