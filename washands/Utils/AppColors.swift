//
//  AppColors.swift
//  washands
//
//  Created by Luiz Felipe Aires Soares on 03/06/20.
//  Copyright © 2020 luizfelipeairesoares. All rights reserved.
//

import UIKit

enum AppColors {
    
    case viewBg
    
    var color: UIColor {
        switch self {
        case .viewBg:
            return UIColor(hex: "E8FAFF")
        }
    }
    
}
