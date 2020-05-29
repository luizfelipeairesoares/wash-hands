//
//  BaseService.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 28/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

protocol BaseService {
    
    func request<T: Decodable>(path: String, completion: @escaping (Result<T, Error>) -> Void)
    
}

extension BaseService {
    
    func request<T: Decodable>(path: String, completion: @escaping (Result<T, Error>) -> Void) {
        let baseURL: URL = URL(string: "https://washands.herokuapp.com")!
        let completeURL = baseURL.appendingPathComponent(path)
        fetch(url: completeURL, completion: completion)
    }
    
    private func fetch<T: Decodable>(url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        
        URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success(let (response, data)):
                if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode > 299 {
                    completion(.failure(APIErrors(code: statusCode, message: "ERROR")))
                    return
                }
                do {
                    let object: T = try jsonDecoder.decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }.resume()
    }
    
}