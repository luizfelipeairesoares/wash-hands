//
//  APIErrors.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 28/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

enum APIErrors: Error {
    
    case unauthorizedError
    case parserError(message: String)
    case backendError(message: String)
    
    var localizedDescription: String {
        switch self {
        case .unauthorizedError:
            return "Unauthorized"
        case .parserError(let message):
            return message
        case .backendError(let message):
            return message
        }
    }
    
}
