//
//  GifService.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 28/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct GifService: BaseServiceProtocol {
    
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = BaseSession()) {
        self.session = session
    }
    
    func requestGifs(completion: @escaping (Result<[GiphyAPIEntity], Error>) -> Void) {
        session.request(path: "/gifs") { (result: Result<GiphyAPIResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
