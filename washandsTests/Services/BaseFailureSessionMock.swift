//
//  BaseFailureSessionMock.swift
//  washandsTests
//
//  Created by Luiz Felipe Aires Soares on 08/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import washands

struct BaseFailureSessionMock: URLSessionProtocol {
    
    func request<T>(path: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        completion(.failure(APIErrors(code: -1, message: "")))
    }
    
}
