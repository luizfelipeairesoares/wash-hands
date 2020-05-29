//
//  GiphyAPIEntity.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 28/05/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

struct GiphyAPIEntity: Codable {
    
    let id: String
    let url: String
    let slug: String
    let username: String
    let images: [String : GiphyImagesAPIEntity]
    
}
