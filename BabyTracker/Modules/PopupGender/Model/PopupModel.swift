//
//  PopupModel.swift
//  BabyTracker
//
//  Created by Мявкo on 15.07.23.
//

import UIKit

enum Gender {
    case boy
    case girl
    
    var value: String {
        switch self {
        case .boy:
            return "male"
        case .girl:
            return "female"
        }
    }
}

struct GenderModel {
    let image: UIImage?
    let title: String
}
