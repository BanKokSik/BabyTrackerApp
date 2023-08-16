//
//  CustomTabBarPresenter.swift
//  BabyTracker
//
//  Created by Мявкo on 3.08.23.
//

import Foundation

protocol CustomTabBarPresenterProtocol: AnyObject {
    var tabBarViewController: CustomTabBarController? { get set }
    var setSizeOfCell: CGSize { get }
    var getActualCellAlpha: (Bool) -> Double { get }
}

class CustomTabBarPresenter: CustomTabBarPresenterProtocol {
    
    weak var tabBarViewController: CustomTabBarController?
    
    init(_ controller: CustomTabBarController) {
        tabBarViewController = controller
    }
    
    var setSizeOfCell: CGSize {
        return CGSize(width: 71, height: 71)
    }
    
    var getActualCellAlpha: (Bool) -> Double = { cellIsSelected in
        return cellIsSelected ? 1.0 : 0.5
    }
}
