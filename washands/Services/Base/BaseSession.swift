//
//  BaseSession.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 08/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct BaseSession: URLSessionProtocol {
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func request<T: Decodable>(path: String, completion: @escaping (Result<T, APIErrors>) -> Void) {
        let baseURL: URL = URL(string: "https://washands.herokuapp.com")!
        let completeURL = baseURL.appendingPathComponent(path)
        fetch(url: completeURL, completion: completion)
    }
    
    // MARK: - Private Functions
    
    private func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, APIErrors>) -> Void) {
        URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 299 {
                    completion(.failure(APIErrors.unauthorizedError))
                    return
                }
                do {
                    let object: T = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(APIErrors.parserError(message: error.localizedDescription)))
                }
            case .failure(let error):
                completion(.failure(APIErrors.backendError(message: error.localizedDescription)))
            }
        }.resume()
    }
    
}
