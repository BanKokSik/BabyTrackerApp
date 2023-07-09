//
//  RootView.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 09.07.2023.
//

import Foundation
import UIKit

protocol RootView: AnyObject {
    var presenter: RootPresenter? { get set }
    func start()
}

class RootViewWindow: UIWindow {
    var presenter: RootPresenter?
    
    override init(windowScene: UIWindowScene) {
        super.init(windowScene: windowScene)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RootViewWindow: RootView {
    func start() {
        presenter?.start()
    }
}
