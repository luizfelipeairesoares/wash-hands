//
//  GifService.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 28/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct GifService: BaseService {
    
    func requestGifs(completion: @escaping (Result<[GiphyAPIEntity], Error>) -> Void) {
        self.request(path: "/gifs") { (result: Result<GiphyAPIResponse, Error>) in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
