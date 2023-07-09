//
//  Presenter.swift
//  BabyTracker
//
//  Created by Алексей Поддубный on 09.07.2023.
//

import Foundation
import UIKit

protocol RootPresenter: AnyObject {
    func start()
    func setWindow(_ window: UIWindow)
}

class RootPresenterImpl: RootPresenter {
    weak var view: RootView?
    
    init() {
        
    }
    
    func entry() -> UIWindow {
        guard let rootView = view as? UIWindow else {
            fatalError("RootView is not UIWindow instance")
        }
        return rootView
    }
    
    func start() {
        let pageView = PageViewController()
        pageView.delegate = self
        onBoardingView = pageView
        entry().rootViewController = onBoardingView
    }
    
    func setWindow(_ window: UIWindow) {
        self.view = window as? RootView
    }
    
    //MARK: - Private
    
    private var onBoardingView: PageViewController?
//    private var loaderView: LoaderViewController?
}

extension RootPresenterImpl: PageViewControllerDelegate {
    
}
