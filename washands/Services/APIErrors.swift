//
//  APIErrors.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 28/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct APIErrors: Error {
    let code: Int
    let message: String
}
