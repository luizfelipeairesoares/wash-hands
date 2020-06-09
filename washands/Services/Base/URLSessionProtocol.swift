//
//  URLSessionProtocol.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 08/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

protocol URLSessionProtocol {
    
    func request<T: Decodable>(path: String, completion: @escaping (Result<T, APIErrors>) -> Void)
    
}
