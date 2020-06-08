//
//  AppLocalizedStrings.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 03/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import Foundation

enum AppLocalizedStrings {
    
    case circularProgressView
    
    public func string(key: String) -> String {
        switch self {
        case .circularProgressView:
            return NSLocalizedString(key, tableName: "CircularProgressViewLocalizable", comment: "")
        }
    }
    
}
