//
//  BaseSuccessSessionMock.swift
//  washandsTests
//
//  Created by Luiz Felipe Aires Soares on 08/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import XCTest
@testable import washands

struct BaseSuccessSessionMock: URLSessionProtocol {
    
    let mockedData: Data
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    init(mockedData: Data) {
        self.mockedData = mockedData
    }
    
    func request<T>(path: String, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            let object: T = try self.jsonDecoder.decode(T.self, from: mockedData)
            completion(.success(object))
        } catch {
            fatalError()
        }
    }
    
}
