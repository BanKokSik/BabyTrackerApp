//
//  Router.swift
//  BabyTracker
//
//  Created by Nikita Chekmarev on 07.07.2023.
//

import UIKit
protocol RouterProtocol: AnyObject {
    var presenter: RouterPresenterProtocol? { get set }
    func start()
}

class Router: UIWindow {
    var presenter: RouterPresenterProtocol?
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Router: RouterProtocol {
    func start() {
        presenter?.start()
    }
}
