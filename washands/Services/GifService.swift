//
//  GifService.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 28/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

protocol GifServiceProtocol: BaseServiceProtocol {
    
    func requestGifs(completion: @escaping (Result<[GiphyAPIEntity], APIErrors>) -> Void)
    
}

struct GifService: GifServiceProtocol {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = BaseSession()) {
        self.session = session
    }
    
    func requestGifs(completion: @escaping (Result<[GiphyAPIEntity], APIErrors>) -> Void) {
        session.request(path: "/gifs") { (result: Result<GiphyAPIResponse, APIErrors>) in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
