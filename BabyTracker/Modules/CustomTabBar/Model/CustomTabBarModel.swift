//
//  CustomTabBarModel.swift
//  BabyTracker
//
//  Created by Мявкo on 3.08.23.
//

import UIKit

struct CustomTabBarModel {
    
}

struct CustomTabCellModel {
    var image: UIImage?
    
    static let images = [
        CustomTabCellModel(image: R.image.star()),
        CustomTabCellModel(image: R.image.calendar()),
        CustomTabCellModel(image: R.image.ruler()),
        CustomTabCellModel(image: R.image.scales()),
        CustomTabCellModel(image: R.image.bulb()),
        CustomTabCellModel(image: R.image.baby())
    ]
}
